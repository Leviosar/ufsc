// Copyright [2018] FOSS
#ifndef STRUCTURES_ARRAY_QUEUE_H
#define STRUCTURES_ARRAY_QUEUE_H

#include <cstdint>
#include <stdexcept>

namespace structures {

template<typename T>
//! classe ArrayQueue
class ArrayQueue {
 public:
    // Construtor padrão da classe ArrayStack, utiliza 
    // a constante DEFAULT_SIZE como max_size_
    ArrayQueue();
    // Overload de argumentos no construtor que recebe
    // o valor de max_size_
    explicit ArrayQueue(std::size_t max);
    // Destrutor padrão da classe
    ~ArrayQueue();
    // Método que adiciona um elemento na fila, colocando ele 
    // na última posição e incrementando o tamanho da fila e
    // o índice do final da fila (é uma fila circular)
    void enqueue(const T& data);
    // Método que remove e retorna um elemento da fila, sempre o primeiro
    // elemento dela, além disso decrementa o tamanho e incrementa o
    // indice de inicio da fila (é uma fila circular)
    T dequeue();
    // Método que retorna o último elemento da fila
    T& back();
    // Método que limpa completamente o conteúdo da fila e reseta
    // todos os índices para seus valores iniciais
    void clear();
    // Método que retorna o tamanho atual da fila
    std::size_t size();
    // Método que retorna tamanho maximo da fila
    std::size_t max_size();
    // Método que retorna um booleano correspondente a fila estar ou não vazia
    bool empty();
    // Método que retorna um booleano correspondente a fila estar ou não cheia
    bool full();

 private:
    T* contents;
    std::size_t size_;
    std::size_t max_size_;
    int begin_;  // indice do inicio (para fila circular)
    int end_;  // indice do fim (para fila circular)
    static const auto DEFAULT_SIZE = 10u;
};

}

#endif

template<typename T>
structures::ArrayQueue<T>::ArrayQueue() {
    max_size_ = DEFAULT_SIZE;
    contents = new T[max_size_];
    size_ = 0;
    begin_ = -1;
    end_ = -1;
}

template<typename T>
structures::ArrayQueue<T>::ArrayQueue(std::size_t max) {
    max_size_ = max;
    size_ = 0;
    contents = new T[max_size_];
    begin_ = -1;
    end_ = -1;
}

template<typename T>
structures::ArrayQueue<T>::~ArrayQueue() {
    delete [] contents;
}


template<typename T>
void structures::ArrayQueue<T>::enqueue(const T& data) {
    if (full()) {
        throw std::out_of_range("Fila cheia");
    } else {
        size_++;
        contents[++end_] = data;
    }
}

template<typename T>
T structures::ArrayQueue<T>::dequeue() {
    if (!empty()) {
        size_--;
        return contents[++begin_];
    } else {
        throw std::out_of_range("Fila vazia");
    }
}

template<typename T>
T& structures::ArrayQueue<T>::back() {
    if (!empty()) {
        return contents[end_];
    } else {
        throw std::out_of_range("Fila vazia");
    }
}

template<typename T>
void structures::ArrayQueue<T>::clear() {
    begin_ = -1;
    end_ = -1;
    size_ = 0;
    delete [] contents;
    contents = new T[max_size_];
}

template<typename T>
std::size_t structures::ArrayQueue<T>::size() {
    return size_;
}

template<typename T>
std::size_t structures::ArrayQueue<T>::max_size() {
    return max_size_;
}

template<typename T>
bool structures::ArrayQueue<T>::empty() {
    return size_ == 0;
}

template<typename T>
bool structures::ArrayQueue<T>::full() {
    return max_size_ == size_;
}
