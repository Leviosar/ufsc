#unidade = {9: 'nove', 8: 'oito', 7: 'sete', 6: 'seis', 5: 'cinco', 4: 'quatro', 3: 'três', 2: 'dois', 1: 'um'}
#dezena = {90: 'noventa', 80: 'oitenta', 70: 'setenta', 60: 'sessenta', 50: 'cinquenta', 40: 'quarenta', 30: 'trinta', 20: 'vinte', 19: 'dezenove', 18: 'dezoito', 17: 'dezessete', 16: 'dezesseis', 15: 'quinze', 14: 'quatorze', 13: 'treze', 12: 'doze', 11: 'onze', 10: 'dez'}

numerico_para_extenso = {900: 'novecentos', 800: 'oitocentos', 700: 'setecentos', 600: 'seiscentos', 500: 'quinhentos', 400: 'quatrocentos', 300: 'trezentos', 200: 'duzentos', 100: 'cento', 90: 'noventa', 80: 'oitenta', 70: 'setenta', 60: 'sessenta', 50: 'cinquenta', 40: 'quarenta', 30: 'trinta', 20: 'vinte', 19: 'dezenove', 18: 'dezoito', 17: 'dezessete', 16: 'dezesseis', 15: 'quinze', 14: 'quatorze', 13: 'treze', 12: 'doze', 11: 'onze', 10: 'dez', 9: 'nove', 8: 'oito', 7: 'sete', 6: 'seis', 5: 'cinco', 4: 'quatro', 3: 'três', 2: 'dois', 1: 'um'}

n = int(input('Digite o número: '))
resultado_milhar = ''
resultado_centena = ''

while n > 0:
    if n >= 10000:
        dois_primeiros_digitos = int(str(n)[:2])

        for valor_numerico in numerico_para_extenso:
            div = dois_primeiros_digitos // valor_numerico
            dois_primeiros_digitos = dois_primeiros_digitos % valor_numerico

            if div != 0:
                if resultado_milhar == '' and dois_primeiros_digitos == 0:
                    resultado_milhar += numerico_para_extenso[valor_numerico] + ' mil'
                elif resultado_milhar == '':
                    resultado_milhar += numerico_para_extenso[valor_numerico]
                else:
                    resultado_milhar += ' e ' + numerico_para_extenso[valor_numerico] + ' mil'
                
                n -= valor_numerico * 1000
    elif n >= 1000:
        unidade_milhar = n // 1000

        for valor_numerico in numerico_para_extenso:
            div = unidade_milhar // valor_numerico

            if div == 1:
                resultado_milhar += numerico_para_extenso[valor_numerico] + ' mil'
                n -= unidade_milhar * 1000
                break
    else:
        resultado_centena = ''

        for valor_numerico in numerico_para_extenso:
            div = n // valor_numerico
            n = n % valor_numerico

            if div != 0:
                if resultado_centena == '':
                    resultado_centena += ' ' + numerico_para_extenso[valor_numerico]
                else:
                    resultado_centena += ' e ' + numerico_para_extenso[valor_numerico]

resultado = resultado_milhar + resultado_centena

print(resultado.strip())