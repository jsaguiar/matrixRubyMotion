class BanksScreen < PM::TableScreen

  def table_data
    [{
      cells: Banks.getAllBanksWithImages.map do |bank|
        {
          title:  bank[:name],
          action: :select_bank,
          arguments: { bank: bank[:name] },
          keep_selection: true, 

          style: {
            selection_style: UITableViewCellSelectionStyleGray,
          },

          image: {
            image: bank[:image], 
            radius: 15 
          },


        }
      end
    }]
  end

  def select_bank(bank)
    self.parent_screen.select_bank(bank[:bank])
  end



end
