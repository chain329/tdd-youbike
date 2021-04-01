class User
  attr_reader :role

  def initialize(role: 'user')
    @role = role
  end
end