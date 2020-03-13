// Copyright (2020) FOSS

#ifndef STRUCTURES_ARRAY_STACK_H
#define STRUCTURES_ARRAY_STACK_H

#include <cstdint>
#include <stdexcept>

namespace structures {

template<typename T>

// Pilha implementada em cima de vetores C++
class ArrayStack {
 public:
    // Construtor base da classe pilha
    ArrayStack();
    // Overload de construtor que recebe o tamanho máximo da pilha
    explicit ArrayStack(std::size_t max);
    // Destruturo da classe;
    ~ArrayStack();
    // Push é o método que adiciona um elemento ao topo da pilha
    // caso haja espaço disponível e aumenta o index atual do topo da pilha
    void push(const T& data);
    // Pop remove o último elemento adicionado na pilha caso 
    // ela não esteja vazia, retorna o elemento e diminui o index
    // atual da pilha
    T pop();
    // Retorna o último elemento inserido na pilha (ou topo da pilha)
    T& top();
    // Limpa completamente a pilha e reseta o index do topo
    void clear();
    // Retorna o tamanho atual da pilha
    std::size_t size();
    // Retorna a capacidade máxima da pilha
    std::size_t max_size();
    // Verifica se a pilha esta vazia
    bool empty();
    // Verifica se a pilha esta cheia
    bool full();

 private:
    T* contents;
    int top_;
    std::size_t max_size_;

    static const auto DEFAULT_SIZE = 10u;
};

}

#endif

template<typename T>
structures::ArrayStack<T>::ArrayStack() {
    max_size_ = DEFAULT_SIZE;
    contents = new T[max_size_];
    top_ = -1;
}

template<typename T>
structures::ArrayStack<T>::ArrayStack(std::size_t max) {
    max_size_ = max;
    contents = new T[max];
    top_ = -1;
}

template<typename T>
structures::ArrayStack<T>::~ArrayStack() {
    delete [] contents;
}

template<typename T>
void structures::ArrayStack<T>::push(const T& data) {
    if (full()) {
        throw std::out_of_range("Pilha cheia");
    } else {
        contents[++top_] = data;
    }
}

template<typename T>
T structures::ArrayStack<T>::pop() {
    if (!empty()) {
        return contents[top_--];
    } else {
        throw std::out_of_range("Pilha vazia");
    }
}

template<typename T>
T& structures::ArrayStack<T>::top() {
    return contents[top_];
}

template<typename T>
void structures::ArrayStack<T>::clear() {
    top_ = -1;
    delete [] contents;
    contents = new T[max_size_];
}

template<typename T>
std::size_t structures::ArrayStack<T>::size() {
    return top_ + 1;
}

template<typename T>
std::size_t structures::ArrayStack<T>::max_size() {
    return max_size_;
}

template<typename T>
bool structures::ArrayStack<T>::empty() {
    return top_ == -1;
}

template<typename T>
bool structures::ArrayStack<T>::full() {
    return top_ == max_size_ - 1;
}
