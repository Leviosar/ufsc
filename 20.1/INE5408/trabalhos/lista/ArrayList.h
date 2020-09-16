// Copyright [2018] FOSS

#ifndef STRUCTURES_ARRAY_LIST_H
#define STRUCTURES_ARRAY_LIST_H

#include <cstdint>
#include <stdexcept>

namespace structures {

template<typename T>

//! classe ArrayList
class ArrayList {
 public:
    //! construtor padrão de ArrayList
    ArrayList();
    //! overload de parâmetros no construtor que adiciona um tamanho máximo
    explicit ArrayList(std::size_t max_size);
    //! destrutor padrão de ArrayList
    ~ArrayList();
    //! limpa os elementos da lista
    void clear();
    //! adiciona um elemento no final da lista
    void push_back(const T& data);
    //! adiciona um elemento no início da lista
    void push_front(const T& data);
    //! insere um elemento em um dado índice da lista
    void insert(const T& data, std::size_t index);
    //! insere um elemento em um dado índice da lista, mantendo o ordenamento
    void insert_sorted(const T& data);
    //! remove um elemento de um dado índice da lista
    //! retornando o elemento removido
    T pop(std::size_t index);
    //! remove o último elemento da lista, retornando o elemento removido
    T pop_back();
    //! remove o primeiro elemento da lista, retornando o elemento removido
    T pop_front();
    //! remove um dado elemento da lista
    void remove(const T& data);
    //! verifica se a lista está cheia
    bool full() const;
    //! verifica se a lista está vazia
    bool empty() const;
    //! verifica se a lista contém um dado elemento
    bool contains(const T& data) const;
    //! verifica se a lista contém um dado elemento, e retorna o índice dele
    //! caso o contrário retorna -1
    std::size_t find(const T& data) const;
    //! retorna o tamanho atual da lista
    std::size_t size() const;
    //! retorna o tamanho máximo da lista
    std::size_t max_size() const;
    //! retorna o elemento na posição recebida
    T& at(std::size_t index);
    //! overload de operador que permite utilizar []
    //! para acessar os valores do ArrayList
    T& operator[](std::size_t index);
    //! garante o uso de constantes
    const T& at(std::size_t index) const;
    //! garante o uso de constantes
    const T& operator[](std::size_t index) const;

 private:
    static const auto DEFAULT_MAX = 10u;
    T* contents;
    std::size_t size_;
    std::size_t max_size_;
};
}  // namespace structures

#endif

template<typename T>
structures::ArrayList<T>::ArrayList() {
    max_size_ = DEFAULT_MAX;
    contents = new T[max_size_];
    size_ = 0;
}

template<typename T>
structures::ArrayList<T>::ArrayList(std::size_t max_size) {
    max_size_ = max_size;
    contents = new T[max_size_];
    size_ = 0;
}

template<typename T>
structures::ArrayList<T>::~ArrayList() {
    delete [] contents;
}

template<typename T>
void structures::ArrayList<T>::clear() {
    size_ = 0;
}

template<typename T>
void structures::ArrayList<T>::push_back(const T& data) {
    if (full()) {
        throw std::out_of_range("ArrayList is full");
    } else {
        contents[size_] = data;
        size_++;
    }
}

template<typename T>
void structures::ArrayList<T>::push_front(const T& data) {
    if (full()) {
        throw std::out_of_range("ArrayList is full");
    } else {
        for (int i = size_; i > 0; i--) {
            contents[i] = contents[i - 1];
        }
        contents[0] = data;
        size_++;
    }
}

template<typename T>
void structures::ArrayList<T>::insert(const T& data, std::size_t index) {
    if (full()) {
        throw std::out_of_range("ArrayList is full");
    } else if (index < 0 || index > size_) {
        throw std::out_of_range("Undefined index");
    } else {
        for (int i = size_; i > index; i--) {
            contents[i] = contents[i - 1];
        }
        contents[index] = data;
        size_++;
    }
}

template<typename T>
void structures::ArrayList<T>::insert_sorted(const T& data) {
    if (full()) {
        throw std::out_of_range("ArrayList is full");
    } else if ((empty()) || (contents[size_ - 1] < data)) {
        push_back(data);
    } else {
        for (int i = 0; i < size_; i++) {
            if (contents[i] > data) {
                insert(data, i);
                break;
            }
        }
    }
}

template<typename T>
T structures::ArrayList<T>::pop(std::size_t index) {
    if (empty()) {
        throw std::out_of_range("ArrayList is empty");
    } else if (index < 0 || index > size_ - 1) {
        throw std::out_of_range("Undefined index");
    } else {
        T aux = contents[index];
        size_--;

        for (int i = index; i < size_; i++) {
            contents[i] = contents[i + 1];
        }

        return aux;
    }
}

template<typename T>
T structures::ArrayList<T>::pop_back() {
    if (empty()) {
        throw std::out_of_range("ArrayList is empty");
    } else {
        size_--;
        return contents[size_];
    }
}

template<typename T>
T structures::ArrayList<T>::pop_front() {
    if (empty()) {
        throw std::out_of_range("ArrayList is full");
    } else {
        return pop(0);
    }
}

template<typename T>
void structures::ArrayList<T>::remove(const T& data) {
    pop(find(data));
}

template<typename T>
bool structures::ArrayList<T>::full() const {
    return (size_ == max_size_);
}

template<typename T>
bool structures::ArrayList<T>::empty() const {
    return (size_ == 0);
}

template<typename T>
bool structures::ArrayList<T>::contains(const T& data) const {
    for (int i = 0; i < size_; i++) {
        if (contents[i] == data) {
            return true;
        }
    }
    return false;
}

template<typename T>
std::size_t structures::ArrayList<T>::find(const T& data) const {
    std::size_t i;
    for (i = 0; i < size_; i++) {
        if (contents[i] == data) {
            break;
        }
    }
    return i;
}

template<typename T>
std::size_t structures::ArrayList<T>::size() const {
    return size_;
}

template<typename T>
std::size_t structures::ArrayList<T>::max_size() const {
    return max_size_;
}

template<typename T>
T& structures::ArrayList<T>::at(std::size_t index) {
    if (empty()) {
        throw std::out_of_range("ArrayList is empty");
    } else if (index < 0 || index > size_) {
        throw std::out_of_range("Undefined index");
    } else {
        return contents[index];
    }
}

template<typename T>
T& structures::ArrayList<T>::operator[](std::size_t index) {
    if (empty()) {
        throw std::out_of_range("ArrayList is empty");
    } else if (index < 0 || index > size_) {
        throw std::out_of_range("Undefined index");
    } else {
        return contents[index];
    }
}

template<typename T>
const T& structures::ArrayList<T>::at(std::size_t index) const {
    if (empty()) {
        throw std::out_of_range("ArrayList is empty");
    } else if (index < 0 || index > size_) {
        throw std::out_of_range("Undefined index");
    } else {
        return contents[index];
    }
}

template<typename T>
const T& structures::ArrayList<T>::operator[](std::size_t index) const {
    if (empty()) {
        throw std::out_of_range("ArrayList is empty");
    } else if (index < 0 || index > size_) {
        throw std::out_of_range("Undefined index");
    } else {
        return contents[index];
    }
}
