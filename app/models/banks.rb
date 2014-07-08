class Banks  
  @banks = [
      { :name => "Caixa Geral de Depositos", :image => "cgd" },
      { :name => "Barclays Bank", :image => "barclays" },
      { :name => "Bank 1", :image => "cgd" },
      { :name => "Bank 2", :image => "cgd" },
      { :name => "Bank 3", :image => "cgd" },
      { :name => "Bank 4", :image => "cgd" },
      { :name => "Bank 5", :image => "cgd" },
      { :name => "Other", :image => nil}
   ]

  def self.getAllBanksWithImages
    @banks
  end
end