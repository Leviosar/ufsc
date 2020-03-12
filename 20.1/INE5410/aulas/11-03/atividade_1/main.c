#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "buffer.h"

/// Reserva uma região de memória capaz de guardar capacity ints e
/// inicializa os atributos de b
void init_buffer(buffer_t* b, int capacity) {
    b->data = (int*) malloc(capacity * sizeof(int));
    b->put_idx = 0;
    b->take_idx = 0;
    b->size = 0;
    b->capacity = capacity;
}

/// Libera a memória e quaisquer recursos de propriedade de b. Desfaz o
/// init_buffer()
void destroy_buffer(buffer_t* b) {
    free(b->data);
}

/// Retorna o valor do elemento mais antigo do buffer b, ou retorna -1 se o
/// buffer estiver vazio
int take_buffer(buffer_t* b) {
    if (b->size != 0)
    {   
        int aux = b->data[b->take_idx];
        b->take_idx = (b->take_idx + 1) % b->capacity;
        b->size = b->size - 1;
        return aux;
    } else {
        return -1;
    }
}

/// Adiciona um elemento ao buffer e retorna 0, ou retorna -1 sem
/// alterar o buffer se não houver espaço livre
int put_buffer(buffer_t* b, int val) {
    if (b->size == b->capacity) return -1;
    
    b->data[b->put_idx] = val;
    b->put_idx = (b->put_idx + 1) % b->capacity;
    b->size++;
    return 0;
}

/// Lê um comando do terminal e o executa. Retorna 1 se o comando era
/// um comando normal. No caso do comando de terminar o programa,
/// retorna 0
int ler_comando(buffer_t* b);

int main(int argc, char **argv) {

    int capacity = 0;
    printf("Digite o tamanho do buffer:\n>");
    if (scanf("%d", &capacity) <= 0) {
        printf("Esperava um número\n");
        return 1;
    }
    buffer_t b;
    init_buffer(&b, capacity);
    
    printf("Comandos:\n"
           "r: retirar\n"
           "c: colocar\n"
           "q: sair\n\n");
    
    //////////////////////////////////////////////////
    // Chamar ler_comando() até a função retornar 0 //
    //////////////////////////////////////////////////
    
    while (ler_comando(&b) != 0)
    {
        /* code */
    }

    destroy_buffer(&b);
    return 0;
}
