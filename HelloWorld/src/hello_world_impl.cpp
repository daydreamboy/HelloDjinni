#include "../generated/cpp/HelloWorld.hpp"

using namespace HelloDjinni;

class HelloWorldImpl : public HelloWorld {
public:
    static std::shared_ptr<HelloWorld> create();
    std::string fromCpp();
};

std::shared_ptr<HelloWorld> HelloWorldImpl::create() {
    return std::make_shared<HelloWorldImpl>();
}

std::string HelloWorldImpl::fromCpp() {
    return "Hello From C++!";
}