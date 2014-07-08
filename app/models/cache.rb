include CDQ
class Cache  
  def self.set( key, value )
    zipped_data = NSKeyedArchiver.archivedDataWithRootObject value
    NSUserDefaults.standardUserDefaults[key] = zipped_data
    self.synchronize
  end

  def self.delete( key )
    if self.exists? key
      NSUserDefaults.standardUserDefaults.removeObjectForKey key
      self.synchronize
    end
  end

  def self.exists?( key )
    !NSUserDefaults.standardUserDefaults[key].nil?
  end
  
  def self.get( key )
    if self.exists? key
      zipped_data = NSUserDefaults.standardUserDefaults[key]
      NSKeyedUnarchiver.unarchiveObjectWithData zipped_data
    else
      nil
    end
  end

  def self.synchronize
    NSUserDefaults.standardUserDefaults.synchronize
  end

  def self.reset
    NSUserDefaults.standardUserDefaults.dictionaryRepresentation.each do | key, value |
      self.delete key
    end
  end

  def self.saveImageOnDisk( image, withName: image_name )
    path = self.getPathForDocument image_name
    imageData = UIImageJPEGRepresentation image, 1
    imageData.writeToFile path, atomically: true
  end

  def self.loadImageFromDiskWithName( image_name )
    path = self.getPathForDocument image_name
    fileManager = NSFileManager.defaultManager
    if fileManager.fileExistsAtPath path
      image = UIImage.imageWithContentsOfFile path
    else
      nil
    end
  end

  def self.removeImageFromDiskWithName( image_name )
    path = self.getPathForDocument image_name
    fileManager = NSFileManager.defaultManager
    if fileManager.fileExistsAtPath path
      fileManager.removeItemAtPath path, error: nil
    else
      nil
    end
  end

  def self.getPathForDocument( document_name )
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)
    documentsDirectory = paths.objectAtIndex 0
    path = documentsDirectory.stringByAppendingPathComponent "#{document_name}.jpeg"
   
  end

end
