#include <type_traits>
#include <cinttypes>
#include <utility>
#include <stdexcept>
#include <variant>

enum class sample_type_id { INT8, INT16, INT32 };

template <int Dim, typename Data>
struct concrete_dummy_struct { };

struct dummy_struct {
    template <typename Buff> explicit dummy_struct(Buff&&) {}
    sample_type_id sample_type(){ return sample_type_id::INT8; }
    int dim() { return 2; }
    template <typename Data, auto Dim> auto cast_to() const {
        return new concrete_dummy_struct<Dim, Data>{};
    }
};

template <auto Dim, typename Data, typename J>
auto op_func(const concrete_dummy_struct<Dim, Data>&, J&&) {
    return 42;
}

template <auto Dim, typename T>
struct operator_t {
    template <typename I, typename J>
    auto operator()(I&& i, J&& j) const {
        if(auto* ptr = std::forward<I>(i).template cast_to<T, Dim>(); ptr)
            return op_func(*ptr, j);
        else
            throw std::runtime_error("Invalid type.");
    }
};



template <template <auto, typename> class F, auto Dim, typename... Args>
auto dispatch_t(sample_type_id tid, Args&&... args) {
    switch (tid){
        case (sample_type_id::INT8):
            return F<Dim, std::int8_t>{}(std::forward<Args>(args)...);
        case (sample_type_id::INT16):
            return F<Dim, std::int16_t>{}(std::forward<Args>(args)...);
        case (sample_type_id::INT32):
            return F<Dim, std::int32_t>{}(std::forward<Args>(args)...);
        default:
            throw std::runtime_error("Unhandled data type");
    }
}

template <auto Dim>
struct dilate_operator_intermediate_t {
  template <typename I, typename J>
  auto operator()(I&& i, J&& j) const {
    // Partial instantiation
    return dispatch_t<operator_t, Dim>(
            i.sample_type(), std::forward<I>(i), std::forward<J>(j));
  }
};

template <template <auto> class F, typename... Args>
auto dispatch_v(auto v, Args&&... args) {
    switch (v){
        case (1):
            return F<1>{}(std::forward<Args>(args)...);
        case (2):
            return F<2>{}(std::forward<Args>(args)...);
        case (3):
            return F<3>{}(std::forward<Args>(args)...);
        default:
            throw std::runtime_error("Unhandled data type");
    }
}

using se_t = std::variant<int, char, double, long long>;

template <typename Buff>
auto dilate(Buff&& buffer, const se_t& se) {
  auto input = dummy_struct(buffer);
  // dispatch the structuring elements through using std::visit for std::variant 
  return std::visit(
      [&input](const auto& se_) {
        return dispatch_v<dilate_operator_intermediate_t>(input.dim(), input, se_);
      }, se);
}

int main() {
    int buffer = 0;
    se_t se = 3.14;
    [[maybe_unused]] auto ret = dilate(buffer, se);
}

