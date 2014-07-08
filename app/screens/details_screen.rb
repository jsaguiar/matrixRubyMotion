class DetailsScreen < PM::Screen
  title "Details"
  include CDQ

  attr_accessor :matrix_image
  

  def on_load
    @layout = DetailsLayout.new(root: self.view)
    
    @layout.banks_view = banks_screen.view
    @layout.build
    @title_tf = @layout.get(:title_tf)

    set_nav_bar_button :right, title: "Save", action: :saveMatrix
  end

  def banks_screen
    @banks_screen ||= begin
      m = BanksScreen.new
      self.addChildViewController m
      m.parent_screen = self
      m
    end
  end

  def select_bank(bank)
    @bank=bank

  end

  def isAllFieldsFilled
    if @title_tf.text.empty? or @bank.nil?
      alert = UIAlertView.alloc.initWithTitle("Please fill all fields", message:nil, delegate: self, cancelButtonTitle: "OK", otherButtonTitles:nil)
      alert.show
      return false
    end
    true
  end

  def saveMatrix
      if isAllFieldsFilled
        Matrix.create(title: @title_tf.text, bank_name: @bank, matrix_image: matrix_image)
        cdq.save
        close to_screen: :root
      end
  end
 

end