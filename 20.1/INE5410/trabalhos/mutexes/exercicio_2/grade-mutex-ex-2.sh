#!/bin/bash
# Usage: grade dir_or_archive [output]

# Ensure realpath 
realpath . &>/dev/null
HAD_REALPATH=$(test "$?" -eq 127 && echo no || echo yes)
if [ "$HAD_REALPATH" = "no" ]; then
  cat > /tmp/realpath-grade.c <<EOF
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char** argv) {
  char* path = argv[1];
  char result[8192];
  memset(result, 0, 8192);

  if (argc == 1) {
      printf("Usage: %s path\n", argv[0]);
      return 2;
  }
  
  if (realpath(path, result)) {
    printf("%s\n", result);
    return 0;
  } else {
    printf("%s\n", argv[1]);
    return 1;
  }
}
EOF
  cc -o /tmp/realpath-grade /tmp/realpath-grade.c
  function realpath () {
    /tmp/realpath-grade $@
  }
fi

INFILE=$1
if [ -z "$INFILE" ]; then
  CWD_KBS=$(du -d 0 . | cut -f 1)
  if [ -n "$CWD_KBS" -a "$CWD_KBS" -gt 20000 ]; then
    echo "Chamado sem argumentos."\
         "Supus que \".\" deve ser avaliado, mas esse diretório é muito grande!"\
         "Se realmente deseja avaliar \".\", execute $0 ."
    exit 1
  fi
fi
test -z "$INFILE" && INFILE="."
INFILE=$(realpath "$INFILE")
# grades.csv is optional
OUTPUT=""
test -z "$2" || OUTPUT=$(realpath "$2")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
# Absolute path to this script
THEPACK="${DIR}/$(basename "${BASH_SOURCE[0]}")"
STARTDIR=$(pwd)

# Split basename and extension
BASE=$(basename "$INFILE")
EXT=""
if [ ! -d "$INFILE" ]; then
  BASE=$(echo $(basename "$INFILE") | sed -E 's/^(.*)(\.(c|zip|(tar\.)?(gz|bz2|xz)))$/\1/g')
  EXT=$(echo  $(basename "$INFILE") | sed -E 's/^(.*)(\.(c|zip|(tar\.)?(gz|bz2|xz)))$/\2/g')
fi

# Setup working dir
rm -fr "/tmp/$BASE-test" || true
mkdir "/tmp/$BASE-test" || ( echo "Could not mkdir /tmp/$BASE-test"; exit 1 )
UNPACK_ROOT="/tmp/$BASE-test"
cd "$UNPACK_ROOT"

function cleanup () {
  test -n "$1" && echo "$1"
  cd "$STARTDIR"
  rm -fr "/tmp/$BASE-test"
  test "$HAD_REALPATH" = "yes" || rm /tmp/realpath-grade* &>/dev/null
  return 1 # helps with precedence
}

# Avoid messing up with the running user's home directory
# Not entirely safe, running as another user is recommended
export HOME=.

# Check if file is a tar archive
ISTAR=no
if [ ! -d "$INFILE" ]; then
  ISTAR=$( (tar tf "$INFILE" &> /dev/null && echo yes) || echo no )
fi

# Unpack the submission (or copy the dir)
if [ -d "$INFILE" ]; then
  cp -r "$INFILE" . || cleanup || exit 1 
elif [ "$EXT" = ".c" ]; then
  echo "Corrigindo um único arquivo .c. O recomendado é corrigir uma pasta ou  arquivo .tar.{gz,bz2,xz}, zip, como enviado ao moodle"
  mkdir c-files || cleanup || exit 1
  cp "$INFILE" c-files/ ||  cleanup || exit 1
elif [ "$EXT" = ".zip" ]; then
  unzip "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.gz" ]; then
  tar zxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.bz2" ]; then
  tar jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".tar.xz" ]; then
  tar Jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".gz" -a "$ISTAR" = "yes" ]; then
  tar zxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".gz" -a "$ISTAR" = "no" ]; then
  gzip -cdk "$INFILE" > "$BASE" || cleanup || exit 1
elif [ "$EXT" = ".bz2" -a "$ISTAR" = "yes"  ]; then
  tar jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".bz2" -a "$ISTAR" = "no" ]; then
  bzip2 -cdk "$INFILE" > "$BASE" || cleanup || exit 1
elif [ "$EXT" = ".xz" -a "$ISTAR" = "yes"  ]; then
  tar Jxf "$INFILE" || cleanup || exit 1
elif [ "$EXT" = ".xz" -a "$ISTAR" = "no" ]; then
  xz -cdk "$INFILE" > "$BASE" || cleanup || exit 1
else
  echo "Unknown extension $EXT"; cleanup; exit 1
fi

# There must be exactly one top-level dir inside the submission
# As a fallback, if there is no directory, will work directly on 
# tmp/$BASE-test, but in this case there must be files! 
function get-legit-dirs  {
  find . -mindepth 1 -maxdepth 1 -type d | grep -vE '^\./__MACOS' | grep -vE '^\./\.'
}
NDIRS=$(get-legit-dirs | wc -l)
test "$NDIRS" -lt 2 || \
  cleanup "Malformed archive! Expected exactly one directory, found $NDIRS" || exit 1
test  "$NDIRS" -eq  1 -o  "$(find . -mindepth 1 -maxdepth 1 -type f | wc -l)" -gt 0  || \
  cleanup "Empty archive!" || exit 1
if [ "$NDIRS" -eq 1 ]; then #only cd if there is a dir
  cd "$(get-legit-dirs)"
fi

# Unpack the testbench
tail -n +$(($(grep -ahn  '^__TESTBENCH_MARKER__' "$THEPACK" | cut -f1 -d:) +1)) "$THEPACK" | tar zx
cd testbench || cleanup || exit 1

# Deploy additional binaries so that validate.sh can use them
test "$HAD_REALPATH" = "yes" || cp /tmp/realpath-grade "tools/realpath"
cc -std=c11 tools/wrap-function.c -o tools/wrap-function \
  || echo "Compilation of wrap-function.c failed. If you are on a Mac, brace for impact"
export PATH="$PATH:$(realpath "tools")"

# Run validate
(./validate.sh 2>&1 | tee validate.log) || cleanup || exit 1

# Write output file
if [ -n "$OUTPUT" ]; then
  #write grade
  echo "@@@###grade:" > result
  cat grade >> result || cleanup || exit 1
  #write feedback, falling back to validate.log
  echo "@@@###feedback:" >> result
  (test -f feedback && cat feedback >> result) || \
    (test -f validate.log && cat validate.log >> result) || \
    cleanup "No feedback file!" || exit 1
  #Copy result to output
  test ! -d "$OUTPUT" || cleanup "$OUTPUT is a directory!" || exit 1
  rm -f "$OUTPUT"
  cp result "$OUTPUT"
fi

if ( ! grep -E -- '-[0-9]+' grade &> /dev/null ); then
   echo -e "Grade for $BASE$EXT: $(cat grade)"
fi

cleanup || true

exit 0

__TESTBENCH_MARKER__
�      �<�V�Ȓ����(�H�@H`�N�3�������#�6֍-)�dfx�=����G�۪����a�a�ޥY�U�������Պi�So0^{��R���>���)ӣf{�����\_�|�h���Gd�۱��Y;!!��	�v�r�E���)N�?��I�M��������������:A}4���{w��E����������G�q7��O������s�[;w�q�ûݷ�'=���a��Ԭ�:xw��4+#?$#wB�둥��Я��)Yb �N?�9�&�zP&J���,�T5B�`�����<?&#��ڍI���\�@�@Q=g�93NL��a	n1i�M�\c	�+��tQ��EШ�ZY�_�aw������ԁc���z����~�������������ِ��x���㝊���E6o8q����^�k̪�^L�k{�OS&+��*Fq�`F��`�U ��+�'u�6AS�x � &�@�����b�6��R/�B7��u�1�F�4u\��Nx1H*��K��&�����q��e&� ��G��>r.�y��� }Ϩ1B��3�Mb�4��i�
��aH:���R��Y8������5R��'6���Ͱ�4S�g�((	�a�+$N��Dy�N#��I1i�H��J���,�ʁ2�bP��F�8�Z��q�a@�(H��o�6Z-��.n!p���栌r	h[����~���8��?0�5T�	�LƐEV�;��晕tkIZQ	��,�6hZi�.O``�g3iI�d��SÁ���M��2�l{����o[�槺�j2�I&�)�v���+z��K�Vr_��
GX�HiED(����crV5O������l�_�ճ*�,�����׊������j���xR���l��	X���D̬5�&7��4���τ3�J����d0��7�;�)M��@��O쳜�eGB/��}+Ц�o�i=�W:AL=o����\�}X��yge���}�@D^G�d��3�!	�!8���紹]��ܤ�0׆���\�P�@��>[IM�]J�n�W^K�3�|Ge����DͯG6�(5q��)r.)NZ�SIE�xmB�5!kf��-�)�ƽ��W�[-H�d*�'^+�-�f8*��O��̻æ}O�d���/���]¼��$c2��F�u_��_zݣ�����r��pxp��W�ɡ'�) )?D�5�w�����|6�)7Hb����9b�{~
����/�����D��y��R�D*U&ͅ+
�n���Z��0{�K#4d'F�~4G�SO�ݟm��(C��)�t��BL'���'ݞ�A+F4,���h"G�]������{�$�5h�����v+SC�H:�9u� G��ѴB�>��/[H-������q$4V�L��=6��!�$5C,S��RʠI�QX��k���t�c�3���K3ӣ�d��.�H��Uސ#���!WNĤCk�4����?� Vl��)r�Ͼ�Y1�P�	��E����M�x0�z(Sɕڜ��D	HTNw��m>���ĆTeR���	S�m��������̍C�ϰ��fnH���sS�?��G�U�(�u�ԑ� 8b�N�e�uM��W��6,��i��'��2���?��~�p��@��$H�<k<���%�t��N�l5����lf��Dn�vg(bN;�P���Y<��"UY	k�8,����|���:���YNB��̆h#vV&�n��qy�UM�ve�®�[J����p���+{�.KxKĘ
M!���'<k�|��i-;�� E_Tһra�J�Oy�`�/��j"��u���4��V�7I����������wWǂ�V+w�����|��������=��c���ao��Ԫ��?�u����}x|����^y�������sgi���C�1�d�A~��$ kCz���&�Je�F�=�рzC���%1����L���aH�Β	^E�'�;�z=�'T�4ПBۍ�x�'�S�l%��x�'N�8ÿB��e��4�{��d���ݢvD_�Y���d�Èu���4����Ly.M(��rxEn���$]�d�a�����Wh%��\�o�(�㟗tBbwJل@����7��x%"�)	���_]]5�\r�2�Kr3,/d:�ح���8Ï	��2���ʮ`��B+�h���R�8�G*��,�ҁ �e<���5J/O����d*�Vc#95�|V!XǍ���������o1.Rċ�?9����KH�e4�='��T<���ק4���]Աh�oof�������%��������}��Ǣ����J����'�3��a�(B_��.4Xk���m�
�|9���sg�q%��R� .N��K�C�"�oD�I̶�pU�!�i?%��%g0}�34���������uXkƸ>ď��G�!��� ���<�~x���Rsˀ&�p� 3�i��p^����մ ]/A���r� �G����q'��d�v�iY��<��:�n-b�� 2�j2��E�JJX����m�%Xs�(�����w�)r�сʇ�v1�����w�F�K?Z@��6����bliP�<T[e^ng��+ ;x��4AQ>z�%װd �Z��
� dg'�\&Ɇ^W� _��@:�H)��˼%�NI�d���U�T�:����6I�x����a5݀��$`,}CӣZ� �6�2�.�C��č�YL�#�7ؙ%wiY��>�)� U+b�.y��W����g�Av4CQy�;DJ��Kg����I���N�����\��F�!��^�w�����v�w{���^���c�h�'�'ۮ<ag�t�����l`!.Y� ;�H4ώ�m<�6��$���v�҇��˧8�?����Nj�FSX�]���9�g�0��<j��M�*Ԝ�ࣰӈ�B�^����l��1,�:V��;6A���}3/r/<0n)�R?03�A�Q��|hb	�D#@�ޏv,*��2��_z`�3�'��H���q��,��5��-v��M�eo�-�$\�M68����6��9��ol��l���kj��B�ڑ3&T���J���4���j��؅W����<��ٰ��U��2��i��NU�y��f5p�_����Uk�`j��J6tة����Ι_�G�2��ȕ�p�Y�/��qX�������~7i��/�������Fs�a���4w�v"����	�a�e��Au&z��s[ϛ:�8��9ZC#�������iR�qt�7{'|�RsWb���V��כ���Ha8���`N;<�UW�pB6��B����,�L�!5��Y`UVT�s�}����Q�������#��b�;<)�~�Χ3�
�1�I1��@@�SX�]��<1���+�	*��N��ڵ]*��̛G%��
�f�J�9��{�u����;{ncpg'��a[���{R�����ya��oWnt?r�w��VNXw�YH��!Cu�	�������D�)��5������4�W���5>�F�RI���CkF>3��J�Jb��Xq�N��1�4����D�'/a�b��|<��8-�;��b>3Ұ�\D���l���2��:}�i�[1RI6V���ZQ��HEƢ(X�R�z"I�+�&�2�|��Oȼ�+�'���Ci�`tߐ0 Ñ]�QI�\'�4-rdߓْjuS��LV��͉��"˫(b?+�4�S1�%��_D'c�i&�G�~�rŬ"$����$k���gY,�_��$��4�E���<J���R:�OH�y��<-`KQh"�Y��4�hfa�Cm��"+"��z��W������=(�T��آ��2���J�AL��y�g�0�l�Џ��NH]�t.�\a����{��>�
�
V|2����!S%,��8������v��]
 ����q�p��-g�F�-��s���pY�Y�4A�3a#}���30�X2&��gu ��Pd��,+}�ԘBt�6�`[L��.����E{g:YJ�K�.X�܂K�D�uj�n�9.٠Uf��X��od�	c��8��,�)�Z7�F��|N}9��{Z"�����\x	<�8��4g_��8�Y�� �S���c������q���`�F�	%Z^�Fs�,v�3閡O�<��.v<KZ��Wb�Y�( ��Ű	��]Bv���;�M@�|�N��C�<,��ީ�8U��z�2�"�:�t>=�Q/E��j[����"�br������:�\н_�-8*𺲪�rH����s�zFWYkZp�:�'ٛ\qڽ��a�Q��Ӈ��v�^[E��^��}w��@�u��_��D;���ޟ jA�: �ϭ���\T�b7�3Ƌ2L��������ĳ�<�Y�$���2�g�&�#�N9�(�RŃ����r�z��?Q���7�>_�_+é�>	�|jϙ|���Bx(����w9"G�j������,GWx/5ߊA�J�D�"@T	h�g��\����Am�c�@�s�`�@J>vAH?�)^���j#\^��i�^�Ď���/;>=c��`��|�ڮ�Vk��F�h�լ����&�m��x��ƋY_�|����F����h��R뫍 �W_��x�����M�@����/���:4���K��h��!�v�+����\��&Jx����?�Ub�N	�����ܪWs�+lu2��8��&��\�,߱��&�aaO99u�D�P�ƥ�Q���&�+i�ej��� �N�6-�h�	�8\cͬ7�Qk��/�gU��4ҋ�8�Y7�=eO@�����i�1U�� +	�5�W�4��c�?qp�UG����vǷ��� 8m���܀�A`�¶�5p��d�^�(�T�]Kn�{�:���-Z�����Ƕ�Ï�v���'4��~�)��ak�8�*��K��½)ő�?����z�z�oT��3���l5��ؕt��]mJD�m,���sˁD0��
�l��[�K���PB&S+X�J:�&`Mv��K{w�����ϻ�cA�_������ڛ��������c��?�Rr��dƔ��
��l4[E���Cv��a�:;�H�;(�C������?ƾ��Gx�҂iP1k�:?�l�!X����ܐN�k:���V씢G�;���;I���vm��j���2r�#����G�HfNa'������u��٥`h��r�y$���n��#���H������z�l��[��H��.҉�X�.�B��DŴ��`*�J[y��`8ڸ`�%�q���:u"�* ��0�����U�"�czPd�tE�*���L|g�Q�B븝!!;���}��$v�]$�/N�� $GT2�
T�xl�(�9�lS��������h�֋�^�Rn �aX��N�w�Z���`��ǻ�c���\o��?������ۧ'd��t;�'��t����Bg���lN�=�׉�8�)���������3�*��^w��ݷ�O�:K��	^���'b�����W�}��`�V�����i3v:P��
�J: ��l��{GF��L�����WP��q5!����`FX�����Z.���)� ~�� �8�o���	�M��A�0Sg0&nm�́X�z�n�Yr����nA��D���o�9�G�嬉�}�!^�C�{����:���ҷVm�	�\������N1��_����W'�~ҵ9~�=j����o�O~���������V����0����m��&�����<�G�����6[Y���\�������o{?����.��rmOs�����!�f��(�*�s:�_�a�ړ�W\�zIz8Gi�w�Vi� ��P�JS/P�55��C�-�g�1$�-"��Y �YMw��؆���vl�|�}���o{O��Ƒ�}�~E#�#�� l'{QpB ;܋x�]ǫ3H�-�hgF8�Ï��=���S�}����[�����!LH�Ü��tWWWWWWUWWǧ��p��Z�(m�P��I�i.����ip���$֚~A�0x�Q�*�V���A��~~ցF^���Xt��{s!%g�����9�@�~�PI�탃C��P��o�b�m��Ex����=�sE���>�+J9�$��N^C�����~�w���55IL0:{p�.D�e�T�SP�j�b'�q�ZTK�f�"�i.8	�9J��s� Գ�Au�*c�k3ut�'!��8���R-o� ��nQ��Y�E�����+[�?��Q&������o�qx�+V][�F�ax�の���9J���t���*X\��
�V�g����/�-�<�ŷVaN�D//�p[Q�
�R��m� ��p'�������D����;c��&���4�&PRnHC��'KsRQ;2��׏��x��z��_�<�D<��0tjZQC���w<�y�K^!�X���d^AK�����j�`%ks�{�F���A�G�@��	�&g_C ���n��DL0�3ڎ����19�G��ӳY;0���}Ч��9������>�6Fc��짲@�n�ȋ���u����`cwL(QE��[��q��q������w���R;e�
I$Ks�᮴�D�Mj1)��N;�Ԣ�hLc:ԑ���ݭ�����������7z�ba�s0�$����fI܃���zy����R�8��*�ʜ+��&/��S�=��̺�V/��R��Y$�+ܖN���QK�X�`v�A��Y��Y_�{���:P�&JU�$���GcG;�}�L�)Fk,B���L���� z�h�Er�!�69�--��������K�����Ŵ�^,L��x�~SQ�d3x��XN+��Y�g)�$���\����	�4���S�3�����.f��dGzT}��Y5:��sw�(�¦�WZ^�Yk���ER��h��I���#�ó/�D5xj��?_o��<O���8�|��{3OO8����UȪ���Q�U�/�.d�4�H��x4�g(����ǠjW�J��B���|t,�}����w�HӔb�̱(G�4
Ʉ0���խZz�)�Y��K�;�;Ⱥc�j��� 6TҁJ��}#cCׁ�܅7x���+�|��U�X�b��N�0�(��u��q7��C�UA[ڏ��t+�r�m�Q�����)�؄�%ڏsy��O�k�}]�g�$��^��XC��v����>^���D�^\D�6Zƕ���|4��ڍvb��J�C.Z�U���-hϻ�J����l��W��B��#g^�ܙ(Q��WsO2�މ7�D�iA�;������O�t˕4�͊V� bT��Qh�����BG�f�1Q[ōp��D�Qmlm?�z���aEpT苣�XD�qF��~8{!�g��AD;�7q��~j������������@��`6������������_��8(ڻ��)Y��"-�⃊:�;���`��?����,������m<�.�=�0M�K�}#�fRJyϒ�����pvn�4�7�ݺ�7I#6xq����6o��]�(��H�m�U<�a@§�8P��@� y�nCr?�C��!E�c�F��f2΁�͑�>�2z�+�@rO��@�窓���~��t��7�5�\N������0[d�y^�����;_��E90hm��x��s��v�sOG�X��&r\�g*+������]i����R�М���Z?[���l}�����.\�ry�X�b]ӧ��J��C���;�r���?т��0��&�Zy̵o�7�������拃Ý�l�9*ay���ct�cÑ�{�� ��ȝx�tt<K��<<���tS��(�I�R3o�YS��W�:z��
����ۊ�[��>��H�T����Wjm��3�L��e����j,�n6��ZA����v�	�y��G{W˅B��!��p�`�9��w��׽��P���� ���ajQ,C"�Y0�'_a1��צBUUJ�BW]Q��*-��9eX ˅��Ոi�|�b���Fx=΍��*��Yj�-X�?fe�W˼"]\Y*R�J0��A��D1&n��2��Q�$

R��GS@x�ԥ�K��|��C���;�*I���Z�N�	�	c�.)�w:��&þ�Eg%.j9�����a[�YѺTGriq�:5�f��mJY�c`T2�J�RM���� Kc�x��X�^#3���G��-��6sf�!�N5�4I\�0G�P��g�Z��n2���t6�U>
���}�t��"��:��%�ɸr�kY�h]��]n��Α�KF��MҳQ��θ���f�H}�?1������ȓ=Ç�A�ǎp��`���9
�@��t 񩃶���*Ê��i���`l��De�1f���[H&3�<�d�����"�RA_��M�^����טH_!��lV�_�lK��i^'YS�}*���{)zU��NF'v�k1vJ�*���Ν�$Ǌv�f��*�����V��D�;���Qŉ�+����9�8n��u�N��A��`A���zLrl�BSZ�(;�Ǩ���]|I�u� �"n��M5̅�T��+	�qlQ?<�~��!女�y�Vb�{��%�O[���\�\� ��Y|��,RYau�������l�}R�U���E��E��y(q��]ur�T��ϓZƅzʼ��ǰKHk(]�
R����ZM�v=_�in'�8]�����m���L�n�*N�T�����Ͻb���Ŭ��I*tx~m��IG}��˹�(t�m�m,$�\�G��Z��im�����<z��t���jxLc��4�G:z>�zIg8�JHg��:餼�D�L��HW�v��A2�L�xf�cVaF�X'B$�p����	��U��A4��b61G ^��U�_Q"��L􅶄jn��cq ��]g��5#�"�5q޵��f��)0F��}�s�Te�N=پ�����ᚌ��.�'��́�������7e��� �^]��Z�m`���d���}<�=�h�'��c��vm�in��:-w��ak�hl0�\��/-Z�����Vj�n,L����u-���y��,�E;���PҶr7`�]
��|���\sd;��� ��2z���E�[�����ݢ��0g� /�*�[��W��0U��b.M�ğp�;��-�R�����s����qزɪ�F����y8���+H�ea*U�ظ����<L!~J��0ӣ�t)v��0��E�r��OUn����)l�4^�1`��)���pG �81��K�0�fP�a�� &at�d��E���i�{1�b����mӶ)�$1�#�*,�{2>Xk�̦R��6U���T�>�,/�G�l�~�O6��LcW�Ͳ�>):�,T-��9���1s|���(��I�1K��*'���?�SZ���e|��'�q�W�
��f7�S�63��A�M0e�`��,̩O�)4+kԜ�M=�u�v�Rm����
�!� �h�fP�����l��7�u��(
=�yVR��4^�<��A�%uB}P`�q�)�[}��B(��8@)�8;�IS"'3SW� �_��kE���^�g���t���\P�GlA���Ic`
+rm��أ-V9A�4��65ѿP�p��c'�,{_;�D�f�)�� x����%�xi�&/H�~�3��ؑ��������+�X^Tv��|�j:f�U'CX�0d�p;POx�8�s�A����}��$Ԩ8	D���m���y?���E��!��5D9�)*������=�˽��m��V�J��ƣz\W2im�s��\�w�\09Ӏ����C�h&A�u�iˣ뵱�F-}�x��:�>�y�����H7��'��8'd9�+r�"�|,��ɧ*W* �?�9�n�3��>�x����:���m.���T�5 ��{�7q8�����?EZ�\w�h���x ����n����Ѫ����m9���A��]S��93<�xZ�����řZ1�3�L���OS��yZ!�\i+n����p�V��.��1����u6��=t;I��_y���r$D�9ɉ�s��rI����Uu�q|����S#!
c�����Ga�1�<pw�?�k4���_����lbӖ������9�c���p'�I�TE�U̅�4��d;��)MP¶���K0o	��F��ܟ�i��@�j ��?�$.z�=�Ь��̘�gь���Qp�#wu.���9�v�윱#��Aμ�3wŉH�JXV���O?�T2��ɫ�;%�B�\qP�A�9EU�_Y�~��q���}a�xm�n|�b�XT؜+j�p�;���\Ԃ���n�c�-
�w�8���^�u�J�a|3�,��c�F��K����/s��Nժ�X��ꚥ�U��+��Y����=8@f�$�z�1�BU�X�w*�Re�7�\�v�����Oݡv-m������j���������n�q�������~��F	�ʾqp\p�_޽b줓�N���)�&�7�4�Sn&�F��q�L��)*#�f�^^l�6\��$�"-Y��LF� 6 >��k��w��& �`�������+(��{ �)m5��*�o	.�}tlXq�EwˣX��eB�
&�a����Q��gW3Q�HeavT�v����be� ��[fq����A��9�ܟ�hV�s�r�͗PDY�ɼ+c�9<ߥ���'����sp��+�#{��+�o��x
��ŕ;>��U��4�f4~G�T��"��1Jjc��'�):���,�,��C�͙x%����H��+���Z�	��ʓ$����I籦qW/§s+a��L�d|Sm��T%���{̞�y�ڟѷ����-�d��C��E�S�p�9�ll�� �uX�0�.%�n�/�4��56�״���}���k=ʜ�55�����`8L]%J4秮$���MNڏ�04E�$��#��ҩ%�W�O�U���i]�Nk��؋f��M,P�ǂ���t�I\�����9�b�7ȱ�|��h��5��y�.�˘��q���|��۵����GJx���!G�Fz��)�֝��:U��}6��1��;�s���+�Yf���܊r���8á6�-�ӿ��^�Q�&S��G���(�������+�n���xp��|z��:���8���$��6J�����}�|����g�q��`2���Q�Ək�n��|\��S?N���S6�?�|�Af�g�v��ȣ�=|�� �tL�;�6��BP�Gߑ�N��u$�2��Ķ^�i7*�"��i~��
���Q*�&^x�t��;Ffc��,+3a�mPE����ۋO�m�J�Fݜ��Y���/<�Vթ{1G�Opc�6�f�c�ĳ��Œ�C�e������^���0�0#�Rz�g�EobL�H�<?ׂ�@~�IT�6��6��g'/.�����G�G^	F����!�m�敒i8i�R�%��H��i�4����pY�-�;��%���ϴ6'��Ŝ[1��?i2�o�=��a�<���*���M7{+L\wE0�F���d��Z9Z��Ѫ��t�e�P<�����������s=�X��6FS2u��>Q���:��Ø��m���=�\������/�p�/Xhhb֓�g���p$~�{ �4����� �3g���� �۔��
R�Ǽ�%�#l^?:�k��i�`�3[���5�O]:��۵���-X�2y8�T����,��{=��ŉO�K�G��K���}d�G�C�f�i�?C�(Y���/��M#��6�y?W�yh.���MР+��+^�\������r}0����E��f*�4�~�%d�:���"|�����xE���4��&7N��z*\�'�Yr$��Q̀��,��+��l, L��.�"z��!N0�~�Š�=��P�ۥc���yHK��Rp�U��V4M�TJ�1\��Ô6W�ٞ�Afuh��ď}�i�d�(ң�(��#��PHz�ʥp-��0+V��(fg2@N��4"�G��Ɨ�N�Kʏm5Γ�Cum����ӥ%:t��-X�K0LfX���`�\��{`���}d-�9T9ҏeLaՂ97҈��R���thC����53$Z0�ph�E<b�m�}/�M�R��T�ML������&�����x�(��_Y�ܶ�>z��������B�8{�^rV��xu�l#��
|E�&?��I�#�qD�>�
	bu&��U���8�q�Χ-�zLz#���Y�ukw�f4����$�F�]��T@���~�Fi�i�U���),��`�ՆS��=	`�ku[�ۅ���x�(N��[R��k{���j �HCt`�s��E��}���U�HJ���ӆ^I�ݘ��F�OP�$˵���c���H;H�ʚ��訰d~U���`ސ�eB���w��8��>��'����*yeW��١"Z7$R� ���TB~2��s���O�(�nw�>�G�ƙ?���.�����=�"����p�V���S��t�KzT���{�e�=�ݭ��^V�����[���lk���#��)^,���e��y4�R\+
����kyZPd��9m�,\�m�f����Ux���Z׿e���Vys�~���
T_�^�~�����7�H��^�P@��B��Ś���SX���e����	,z`��ҙ^�Q��ak1��yq|�۰	��dv�myiu�e��D eq�wi�Z�J��� �դ���k=�.�}Z�j+5��~���DW�����u)u
��k�:&����	����r�Ql����sV�*`M4�nJI�>�o;�i3uW(A��@��R/��,8��th�@̸Ɠ��m��Eچ�E*�k��]�Y�9�DU����I"W_�����*]�-f*3�+!J�2h�F#�h�PSDeY"�x'Ns��4�-��ցNS?l�%�n�#�\��U�3*��bvM�	g�v��c����NƙA�X1ȔK)�0[�a��%KQ�/�:��pRBW�(��`�Q����B�.�K�V�͈yԀ9M�8��i=#��-��\�w�c�������'fo�1Z�"l&�iy�D�]��<�Q�Rj<�}[u~���du����R看?������?�-��6������o�����|����p]�Ӑ��`�p�����p����������s�tNIgo����?Hc��w�l����&��G��
m	�9S HA�{�̚D5c����=�Z�5q�������7�q<!���';Ϸ��U����o4��p�_�����z '�ԇQ����&�;�%������κdן�~'��0I��d6�ڨD�P�6@ >X������y<'�������J�`)�0�f��(�ts����#���X����忈�{��-�xl�mt�4�R�>��.�E��� �s�ň�݄�gi:]�����u�a h�n觽���=ot�C��fi����:�~�ݼ=�}>zώЧ�y�l���B�g�x�[lu�FlȆ^��H��X}hB�l�
F��赟F5Ɓ�닍� h��#����o�7����g�1Uz��q'�iּ�ض@"Q�@�O(�aգ�D.1PDe������=�ڝ��z��p��&c��U��p����ӽ��6�VqL'Ȏ0�#��-נ#S/Mf�IJ� k��R7�y_ut^#+L=����)�%mhx��.F><b��1�Ѧj��������E:S�؀���9h�����9-|w��?x�������s��=�R"Ǜ����z픆 �ȿa��?�ϧ��[X��G�W"�_ z��3o�w�]�Gc�a"��۴7�uGۛG�[�=�^1M:	Y}|o�(���o��v�ɚ��deZ�f��y�u�ԛ^{4fB|��#� �޲Sy�Ok&cV��0֬:��ts�I�8�
|�@�y���Gp`����[l�#�D۝����.�A���J�g{�	K?"ik��ٜ��	J-6L8�O �(K{�q�@�&A��M)����׳�|��@i�>(�k��T�G�+�
����^�o���Zw�۽�]�f�VX�x���G6D��"�K����F��<�q�mu���6"�~�/bm�wk0�$���'�{�፩w�1���S���A\Q���C_�8	ӯK���l�b�P�S�K�<�.fli�U�*�p!�_b)�lg2�"�7$ett�K��(�x�����H}*)��9���ckJW���a�}�C3�b�ǾX�a�.�9��8�(Q�Ǹ�G�����}x,F9��2r����3��k�����ӷ��E�uoG�:�2�tޓ���!��ɧϾ��88���4[�և���ʠ�����&�B��ߣڝSּ��4����D��*�;Y A���[�C�Ν,D�@��ºs-$>����䳤�E�ѓ���ό�@�n6I�;����h�),�h}��B��e�"��C7�;���vgr�=���7=��F3���_�>��	�TE$��R�Ўuue&Rz�KL���h�o|�]��CΐAΪՙ�3�|Ū�!�2MEpW�3�.�1��L�z(bi����;�Pt�sb� ���ыu�b۔���|C�����E����v3t����3�N�%��]4��$t�Qt����Z���T:���_�q�����+�q$���F���R�^����,���s��1�I�uxE$����`�J�t�i�?�ٲ:��Tb�s�qL�w���K�t]�&S�!��]����8(溬A#�4��u:
V3 ϢG�H	����g�K�e�f/���\�M��b{�]���0�mp�KM�bٔ�v�F���|�*�H
v��]4M���?
�n��?����{q���R�d�P���mdX8;����O�B4wp�.�5��h�d�'�?�T�^�"u+Y�������R�E��K|��k��F�����}n�����}n�����}n�����}~��v�� @ 