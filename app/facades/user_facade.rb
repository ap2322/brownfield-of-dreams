class UserFacade < SimpleDelegator
  def initialize(user)
    super(user)
  end
  
end
