class DetailsLayout < MK::Layout
  view :banks_view
  
  attr_accessor :title_tf

  def layout
    root :details do
      add UITextField, :title_tf
      add UILabel, :bank_label
      #add UIScrollView, :bank_sv
      #add UIButton, :bank_btn
      add banks_view, :banks_view

    end

  end

  def details_style
    background_color "#FFFFFF".uicolor
  end

  def title_tf_style
    font UIFont.boldSystemFontOfSize(20)
    constraints do
      top 84
      left 10
      right "100%-10"
    end
    background_color "#F0F0F0".uicolor
    placeholder "Title"
  end

  def bank_label_style
    text "BANK"
    font UIFont.boldSystemFontOfSize(20)
    constraints do
      below(:title_tf).plus(20)
      height 30
      left 10
      right "100%-10"

    end
  end

 def banks_view_style
    constraints do
     below(:bank_label).plus(20)
     bottom 0
     left 0
     right "100%"
   end

 end

end