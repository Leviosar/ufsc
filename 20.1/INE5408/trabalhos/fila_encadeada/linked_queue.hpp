//! Copyright FOSS
#ifndef STRUCTURES_LINKED_LIST_H
#define STRUCTURES_LINKED_LIST_H

#include <cstdint>
#include <stdexcept>

namespace structures {

template<typename T>
//! Classe Node, representa um elemento da LinkedQueue
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

//! Classe LinkedQueue, implementa uma estrutura de dados
//! com encadeamento simples, que permite ao programador
//! manipular filas com quantidades não determinadas de elementos
template<typename T>
class LinkedQueue {
 public:
    //! Construtor padrão de LinkedQueue
    LinkedQueue();
    //! Destrutor padrão de LinkedQueue
    ~LinkedQueue();
    //! Limpa a fila completamente
    void clear();
    //! Insere elemento no fim da fila
    void enqueue(const T& data);
    //! Retira o elemento do início da fila
    T dequeue();
    //! Retorna o elemento no início da fila
    T& front() const;
    //! Retorna o elemento no final da fila
    T& back() const;
    //! Acessa o elemento na posição [index] da fila
    T& at(std::size_t index);
    //! Verifica se a fila está vazia
    bool empty() const;
    //! Retorna o tamanho da fila
    std::size_t size() const;
    //! Overload de operadores para que a fila
    //! utilize []
    T& operator[](std::size_t index);

 private:
    //! Retorna o Node que está no índice [index] da fila
    Node<T>* node_at(std::size_t index);
    //! Ponteiro para Node que é a cabeça da fila
    structures::Node<T>* head{nullptr};
    //! Ponteiro para Node que é a cauda da fila
    structures::Node<T>* tail{nullptr};
    //! Tamanho atual da fila
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

// Implementações de LinkedQueue

template<typename T>
structures::LinkedQueue<T>::LinkedQueue() {}

template<typename T>
structures::LinkedQueue<T>::~LinkedQueue() {
    clear();
}

template<typename T>
void structures::LinkedQueue<T>::clear() {
    // inicializa o último elemento excluido como o head
    auto last = head;

    // pega o próximo elemento a ser excluido a partir de last->next()
    // remove o elemento sendo excluido atualmente
    // itera até acabarem os elementos
    for (std::size_t i = 0; i < size(); i++) {
        auto next = last->next();
        delete last;
        last = next;
    }

    // seta o head como o ponteiro nulo e o tamanho como 0
    head = nullptr;
    size_ = 0;
}

template<typename T>
void structures::LinkedQueue<T>::enqueue(const T& data) {
    if (size() == 0) {
        structures::Node<T>* new_node = new structures::Node<T>(data, head);
        head = new_node;
        tail = new_node;
        size_++;
    } else {
        auto before = node_at(size() - 1);
        auto new_node = new structures::Node<T>(data, before->next());
        before->next(new_node);
        tail = new_node;
        size_++;
    }
}

template<typename T>
T structures::LinkedQueue<T>::dequeue() {
    if (empty())
        throw std::out_of_range("List is empty");


    structures::Node<T>* removed_node = head;
    T data = removed_node->data();
    head = head->next();
    size_--;
    delete removed_node;
    return data;
}

template<typename T>
T& structures::LinkedQueue<T>::front() const {
    if (empty())
        throw std::out_of_range("Stack is empty");

    return head->data();
}

template<typename T>
T& structures::LinkedQueue<T>::back() const {
    if (empty())
        throw std::out_of_range("Stack is empty");

    return tail->data();
}

template<typename T>
bool structures::LinkedQueue<T>::empty() const {
    return size() == 0;
}

template<typename T>
std::size_t structures::LinkedQueue<T>::size() const {
    return size_;
}

template<typename T>
T& structures::LinkedQueue<T>::at(std::size_t index) {
    return node_at(index)->data();
}

template<typename T>
structures::Node<T>* structures::LinkedQueue<T>::node_at(std::size_t index) {
    if (index < 0 || index > size()-1)
        throw std::out_of_range("Invalid index");

    // começa a busca pela cabeça da filaa
    auto node = head;

    // itera os elementos indo um a um utilizando next()
    for (std::size_t i = 0; i < index; i++) {
        node = node->next();
    }

    return node;
}
