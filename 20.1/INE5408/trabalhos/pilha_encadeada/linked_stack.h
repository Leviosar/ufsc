//! Copyright FOSS
#ifndef STRUCTURES_LINKED_STACK_H
#define STRUCTURES_LINKED_STACK_H

#include <cstdint>
#include <stdexcept>

namespace structures {

template<typename T>
//! Classe Node, representa um elemento da LinkedStack
//! e suas propriedades
class Node {
 public:
    //! Construtor padrão
    Node(const T& data, Node<T>* next);
    //! Construtor que não recebe próximo Node
    explicit Node(const T& data);
    //! Getter: data
    T& data();
    //! Getter const: data
    const T& data() const;
    //! Getter: next
    Node<T>* next();
    //! Getter const: next
    const Node<T>* next() const;
    //! Setter next
    void next(Node<T>* node);
 private:
    T data_;
    Node* next_{nullptr};
};

//! Classe LinkedStack, implementa uma estrutura de dados
//! com encadeamento simples, que permite ao programador
//! manipular pilhas com quantidades não determinadas de elementos
template<typename T>
class LinkedStack {
 public:
    //! Construtor padrão de LinkedStack
    LinkedStack();
    //! Destrutor padrão de LinkedStack
    ~LinkedStack();
    //! Limpa a pilha completamente
    void clear();
    //! Insere elemento no fim da pilha
    void push(const T& data);
    //! Retira o elemento na posição [index] da pilha
    T pop();
    //! Retorna o elemento no topo da pilha
    T& top() const;
    //! Verifica se a pilha está vazia
    bool empty() const;
    //! Retorna tamanho atual da pilha
    std::size_t size() const;

 private:
    //! Retorna o Node que está no índice [index] da pilha
    Node<T>* node_at(std::size_t index);
    //! Ponteiro para Node que é a cabeça da pilha
    structures::Node<T>* top_{nullptr};
    //! Tamanho atual da pilha
    std::size_t size_{0u};
};

}  // namespace structures

#endif

// Implementações de Node

template<typename T>
structures::Node<T>::Node(const T& data, Node<T>* next) {
    data_ = data;
    next_ = next;
}

template<typename T>
structures::Node<T>::Node(const T& data) {
    data_ = data;
}

template<typename T>
T& structures::Node<T>::data() {
    return data_;
}

template<typename T>
const T& structures::Node<T>::data() const {
    return data_;
}

template<typename T>
structures::Node<T>* structures::Node<T>::next() {
    return next_;
}

template<typename T>
const structures::Node<T>* structures::Node<T>::next() const {
    return next_;
}

template<typename T>
void structures::Node<T>::next(Node<T>* next) {
    next_ = next;
}

// Implementações de LinkedStack

template<typename T>
structures::LinkedStack<T>::LinkedStack() {}

template<typename T>
structures::LinkedStack<T>::~LinkedStack() {
    clear();
}

template<typename T>
void structures::LinkedStack<T>::clear() {
    // inicializa o último elemento excluido como o top
    auto last = top_;

    // pega o próximo elemento a ser excluido a partir de last->next()
    // remove o elemento sendo excluido atualmente
    // itera até acabarem os elementos
    for (std::size_t i = 0; i < size(); i++) {
        auto next = last->next();
        delete last;
        last = next;
    }

    // seta o top como o ponteiro nulo e o tamanho como 0
    top_ = nullptr;
    size_ = 0;
}

template<typename T>
void structures::LinkedStack<T>::push(const T& data) {
    structures::Node<T>* new_node = new structures::Node<T>(data, top_);
    top_ = new_node;
    size_++;
}

template<typename T>
T structures::LinkedStack<T>::pop() {
    if (empty())
        throw std::out_of_range("Stack is empty");

    structures::Node<T>* removed_node = top_;
    T data = removed_node->data();
    top_ = top_->next();
    size_--;
    delete removed_node;
    return data;
}

template<typename T>
T& structures::LinkedStack<T>::top() const {
    if(empty())
        throw std::out_of_range("Stack is empty");

    return top_->data();
}

template<typename T>
bool structures::LinkedStack<T>::empty() const {
    return size() == 0;
}

template<typename T>
std::size_t structures::LinkedStack<T>::size() const {
    return size_;
}

template<typename T>
structures::Node<T>* structures::LinkedStack<T>::node_at(std::size_t index) {
    if (index < 0 || index > size()-1)
        throw std::out_of_range("Invalid index");

    // começa a busca pela cabeça da pilhaa
    auto node = top_;

    // itera os elementos indo um a um utilizando next()
    for (std::size_t i = 0; i < index; i++) {
        node = node->next();
    }

    return node;
}
