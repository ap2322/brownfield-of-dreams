module ResourceValidation

  def in_db
    User.find_by(username: handle )
  end

end
