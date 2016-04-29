class Seeder

  def self.seed!
    self.admins

  end


  def self.admins
    Admin.create(username: 'aids', password: 'hora')
  end

end