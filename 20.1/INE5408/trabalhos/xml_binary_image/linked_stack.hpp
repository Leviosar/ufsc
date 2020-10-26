#ifndef STRUCTURES_LINKED_STACK_H
#define STRUCTURES_LINKED_STACK_H

#include <cstdint>
#include <stdexcept>

namespace structures {

//! LinkedStack implementation
template<typename T>
class LinkedStack {
 public:
    LinkedStack();
    ~LinkedStack();
    //! Limpa pilha
    void clear();
    //! Limpa pilha
    void push(const T& data);
    //! Limpa pilha
    T pop();
    //! Limpa pilha
    T& top() const;
    //! Limpa pilha
    bool empty() const;
    //! Limpa pilha
    std::size_t size() const;

 private:
    class Node {  // Elemento
     public:
        explicit Node(const T& data):
            data_{data}
        {}

        Node(const T& data, Node* next):
            data_{data},
            next_{next}
        {}

        T& data() {  // getter: dado
            return data_;
        }

        const T& data() const {  // getter const: dado
            return data_;
        }

        Node* next() {  // getter: próximo
            return next_;
        }

        const Node* next() const {  // getter const: próximo
            return next_;
        }

        void next(Node* node) {  // setter: próximo
            next_ = node;
        }

     private:
        T data_;
        Node* next_{nullptr};
    };

    Node* top_{nullptr};
    std::size_t size_{0u};
};

template<typename T>
LinkedStack<T>::LinkedStack() {}

template<typename T>
LinkedStack<T>::~LinkedStack() {
    top_ = nullptr;
    size_ = 0;
}

template<typename T>
void LinkedStack<T>::clear() {
    top_ = nullptr;
    size_ = 0;
}

template<typename T>
void LinkedStack<T>::push(const T& data) {
    Node* new_node = new Node(data, top_);

    top_ = new_node;

    size_++;
}

template<typename T>
T LinkedStack<T>::pop() {
    if (empty()) {
        throw std::out_of_range("Stack is empty");
    }

    Node* removed_node = top_;
    T data = removed_node->data();

    top_ = top_->next();

    size_--;

    delete removed_node;

    return data;
}

template<typename T>
T& LinkedStack<T>::top() const {
    if (empty()) {
        throw std::out_of_range("Stack is empty");
    }

    return top_->data();
}

template<typename T>
bool LinkedStack<T>::empty() const {
    return size_ == 0;
}

template<typename T>
std::size_t LinkedStack<T>::size() const {
    return size_;
}

}  // namespace structures

#endif