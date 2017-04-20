# [Performed?](http://api.rubyonrails.org/v5.0.1/classes/ActionController/Metal.html#method-i-performed-3F)

With ActionController::Metal#performed? you can test whether render or redirect already happended.

```ruby
class Controller
  def show
    verify_order; return if performed?
    # even more code over there ...
  end

  private

  def verify_order
    unless @order.awaiting_payment? || @order.failed?
      redirect_to edit_order_path(@order) and return
    end

    if invalid_order?
      redirect_to tickets_path(@order) and return
    end
  end
end
```