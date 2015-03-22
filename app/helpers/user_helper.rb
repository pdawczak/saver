module UserHelper
  def for_authenticated_user(&block)
    block.call if current_user.authenticated?
  end

  def for_non_authenticated_user(&block)
    block.call unless current_user.authenticated?
  end
end
