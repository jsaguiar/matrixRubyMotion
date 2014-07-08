class HomeScreen < PM::TableScreen
  title "Matrix"
  include CDQ
  def on_load
    set_nav_bar_button :right, title: "Add", action: :takePhoto

  end

  def will_appear
    update_table_data
  end

  def table_data
    [{
      cells: Matrix.all.array.map do |bank|
        {
          title: bank.title,
          action: :select_matrix,
          arguments: {matrix_image: bank.matrix_image,title:bank.title},
          keep_selection: false, 

          cell_style: UITableViewCellStyleSubtitle,
          subtitle: bank.bank_name,
          editing_style: :delete,
          image: {
            image: Cache.loadImageFromDiskWithName(bank.matrix_image), 
            radius: 15 
          },

        }
      end
    }]
  end

  def select_matrix(bank)
        PM.logger.info bank

    puts "image named "+ bank[:matrix_image]
    showImageBig (Cache.loadImageFromDiskWithName( bank[:matrix_image]))
  end

  def on_cell_deleted(cell)
    matrixToDel=Matrix.where(:matrix_image).eq(cell[:arguments][:matrix_image])
    matrixToDel.first.destroy
    cdq.save
    true
  end


#show matrix image

 def removeImageBigView
    frame = @matrixImageView.frame
    frame.origin = [0, 0]
    @matrixImageView.frame = frame
    point_b=[0, UIScreen.mainScreen.bounds.size.height]

    @matrixImageView.move_to point_b do |completed|
      @matrixImageView.removeFromSuperview
    end

  end

def showImageBig image
    @matrixImageView = ILTranslucentView.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    bound=25
    imageview=UIImageView.alloc.initWithFrame(CGRectMake(bound, bound, @matrixImageView.frame.size.width-2*bound,@matrixImageView.frame.size.height-2*bound))
    imageview.clipsToBounds=true  
    imageview.contentMode = UIViewContentModeScaleAspectFit
    imageview.image=image  
    @matrixImageView.on_swipe :down do |gesture|
      removeImageBigView
    end
    
    @matrixImageView.addSubview(imageview)
    @matrixImageView.translucentAlpha = 1
    @matrixImageView.translucentTintColor = UIColor.clearColor
    @matrixImageView.backgroundColor = UIColor.clearColor
    @matrixImageView.translucentStyle = UIBarStyleBlack;

    #self.view.addSubview(@matrixImageView)
    mainWindow =  UIApplication.sharedApplication.windows.objectAtIndex(0)
    mainWindow.addSubview(@matrixImageView)
    
    frame = @matrixImageView.frame
    frame.origin = [0, UIScreen.mainScreen.bounds.size.height]
    @matrixImageView.frame = frame

    point_b=[0, 0]
    @matrixImageView.move_to point_b

  end


#ADD NEW MATRIX
  def takePhoto
    #open DetailsScreen
    if Device.camera.rear?
      camera = BW::Device.camera.rear
    else
      camera = BW::Device.camera.any
    end
    camera.picture( media_types: [:image]) do | result |
      if result[:original_image]
        time =  Time.at( Time.now).to_i
        saveImage result[:original_image],time
        
        open DetailsScreen.new(matrix_image: time.to_s)
      end
    end
  end
  
  def saveImage image, time
      Dispatch::Queue.main.after(0) {
        Cache.saveImageOnDisk(image,withName: time)
      }
  end

end