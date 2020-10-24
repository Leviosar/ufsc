//! Copyright FOSS
#ifndef STRUCTURES_LINKED_LIST_H
#define STRUCTURES_LINKED_LIST_H

#include <cstdint>
#include <stdexcept>

namespace structures {

template<typename T>
//! Classe Node, representa um elemento da DoublyLinkedList
//! e suas propriedades
class Node {
 public:
    //! Construtor padrão
    Node(const T& data, Node<T>* prev, Node<T>* next);
    //! Construtor que recebe apenas o próximo Node
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
    //! Getter: prev
    Node<T>* prev();
    //! Getter const: prev
    const Node<T>* prev() const;
    //! Setter prev
    void prev(Node<T>* node);

 private:
    T data_;
    Node* next_{nullptr};
    Node* prev_{nullptr};
};

//! Classe DoublyLinkedList, implementa uma estrutura de dados
//! com encadeamento simples, que permite ao programador
//! manipular listas com quantidades não determinadas de elementos
template<typename T>
class DoublyLinkedList {
 public:
    //! Construtor padrão de DoublyLinkedList
    DoublyLinkedList();
    //! Destrutor padrão de DoublyLinkedList
    ~DoublyLinkedList();
    //! Limpa a lista completamente
    void clear();
    //! Insere elemento no fim da lista
    void push_back(const T& data);
    //! Insere elemento no início da lista
    void push_front(const T& data);
    //! Insere elemento na posição [index] da lista
    void insert(const T& data, std::size_t index);
    //! Insere elemento mantendo a ordenação da lista
    void insert_sorted(const T& data);
    //! Acessa o elemento na posição [index] da lista
    T& at(std::size_t index);
    //! Retira o elemento na posição [index] da lista
    T pop(std::size_t index);
    //! Retira o elemento do fim da lista
    T pop_back();
    //! Retira o elemento do início da lista
    T pop_front();
    //! Remove um elemento que contenha os dados em [data]
    void remove(const T& data);
    //! Verifica se a lista está vazia
    bool empty() const;
    //! Verifica se a lista contém um elemento [data]
    bool contains(const T& data) const;
    //! Encontra a posição de um elemento que contém [data]
    std::size_t find(const T& data) const;
    //! Retorna o tamanho da lista
    std::size_t size() const;
    //! Overload de operadores para que a lista
    //! utilize []
    T& operator[](std::size_t index);

 private:
    //! Retorna o Node que está no índice [index] da lista
    Node<T>* node_at(std::size_t index);
    //! Ponteiro para Node que é a cabeça da lista
    structures::Node<T>* head{nullptr};
    //! Ponteiro para Node que é a cauda da lista
    structures::Node<T>* tail{nullptr};
    //! Tamanho atual da lista
    std::size_t size_{0u};
};

}  // namespace structures

#endif

// Implementações de Node

template<typename T>
structures::Node<T>::Node(const T& data, Node<T>* prev, Node<T>* next) {
    data_ = data;
    prev_ = prev;
    next_ = next;
}

template<typename T>
structures::Node<T>::Node(const T& data, Node<T>* next) {
    data_ = data;
    next_ = next;
}

template<typename T>
structures::Node<T>::Node(const T& data) {
    data_ = data;
    prev_ = nullptr;
    next_ = nullptr;
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

template<typename T>
structures::Node<T>* structures::Node<T>::prev() {
    return prev_;
}

template<typename T>
const structures::Node<T>* structures::Node<T>::prev() const {
    return prev_;
}

template<typename T>
void structures::Node<T>::prev(Node<T>* prev) {
    prev_ = prev;
}

// Implementações de DoublyLinkedList

template<typename T>
structures::DoublyLinkedList<T>::DoublyLinkedList() {}

template<typename T>
structures::DoublyLinkedList<T>::~DoublyLinkedList() {
    clear();
}

template<typename T>
void structures::DoublyLinkedList<T>::clear() {
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
void structures::DoublyLinkedList<T>::push_back(const T& data) {
    insert(data, size());
}

template<typename T>
void structures::DoublyLinkedList<T>::push_front(const T& data) {
    structures::Node<T>* new_node = new structures::Node<T>(data, head);

    if (new_node == nullptr) {
        throw(std::out_of_range("List is full (out of memory space)"));
    } else {
        if (head != nullptr) {
            head->prev(new_node);
        }
        head = new_node;
        size_++;
    }
}

template<typename T>
void structures::DoublyLinkedList<T>::insert(const T& data, std::size_t index) {
    if (index < 0 || index > size()) {
        throw std::out_of_range("Invalid index");
    }

    if (index == 0) {
        push_front(data);
    } else {
        auto before = node_at(index - 1);
        auto new_node = new structures::Node<T>(data, nullptr, before->next());
        before->next(new_node);
        size_++;
    }
}

template<typename T>
void structures::DoublyLinkedList<T>::insert_sorted(const T& data) {
    // Inicializa node como a primeira posição da lista (head)
    auto node = head;

    // Itera sobre os elementos checando por ordenação
    for (std::size_t i = 0; i < size(); i++) {
        if (data <= node->data()) {
            insert(data, i);
            return;
        }
        node = node->next();
    }

    // Caso não encontre a ordenação até aqui, o elemento deve ser o último
    push_back(data);
}

template<typename T>
T structures::DoublyLinkedList<T>::pop(std::size_t index) {
    if (index < 0 || index >= size())
        throw std::out_of_range("Invalid index");

    if (empty())
        throw std::out_of_range("List is already empty");

    if (index == 0) {
        return pop_front();
    } else {
        structures::Node<T>* before = node_at(index - 1);
        structures::Node<T>* removed_node = before->next();
        before->next(removed_node->next());
        T data = removed_node->data();
        size_--;
        delete removed_node;
        return data;
    }
}

template<typename T>
T structures::DoublyLinkedList<T>::pop_back() {
    return pop(size() -1 );
}

template<typename T>
T structures::DoublyLinkedList<T>::pop_front() {
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
std::size_t structures::DoublyLinkedList<T>::find(const T& data) const {
    // começa a busca pelo primeiro elemento da lista
    auto node = head;
    // itera comparando o valor recebido de data com o data de cada elemento
    // ao encontrar um valor compatível retorna o índice imediatamente
    for (std::size_t i = 0; i < size(); i++) {
        if (data == node->data()) {
            return i;
        }
        node = node->next();
    }

    // caso não encontre nada, retorna o tamanho da lista?????????
    return size();
}

template<typename T>
void structures::DoublyLinkedList<T>::remove(const T& data) {
    pop(find(data));
}

template<typename T>
bool structures::DoublyLinkedList<T>::empty() const {
    return size() == 0;
}

template<typename T>
bool structures::DoublyLinkedList<T>::contains(const T& data) const {
    return find(data) != size();
}

template<typename T>
std::size_t structures::DoublyLinkedList<T>::size() const {
    return size_;
}

template<typename T>
T& structures::DoublyLinkedList<T>::at(std::size_t index) {
    return node_at(index)->data();
}

template<typename T>
T& structures::DoublyLinkedList<T>::operator[](std::size_t index) {
    return at(index);
}

template<typename T>
structures::Node<T>* structures::DoublyLinkedList<T>::node_at(
    std::size_t index
) {
    if (index < 0 || index > size()-1)
        throw std::out_of_range("Invalid index");

    // começa a busca pela cabeça da listaa
    auto node = head;

    // itera os elementos indo um a um utilizando next()
    for (std::size_t i = 0; i < index; i++) {
        node = node->next();
    }

    return node;
}
