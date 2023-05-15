#include "../generated/cpp/HelloWorld.hpp"

using namespace HelloDjinni;

class HelloWorldImpl : public HelloWorld {
public:
    static std::shared_ptr<HelloWorld> create();
    std::string helloFromCpp();
};

std::shared_ptr<HelloWorld> HelloWorldImpl::create() {
    return std::make_shared<HelloWorldImpl>();
}

std::string HelloWorldImpl::helloFromCpp() {
    return "Hello From C++!";
}