class User
  def initialize(member: false)
    @member = member
  end

  def member?
    @member
  end
end