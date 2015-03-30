module Auth
  def self.maybe_user(user)
    return user.extend(Auth::AuthenticatedUser) unless user.nil?
    Auth::Visitor.new
  end
end
