class Seeder

  def self.seed!
    self.admins

  end


  def self.admins
    Admin.create(username: 'admin', password: 'admin')
  end

end