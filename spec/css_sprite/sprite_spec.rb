require File.dirname(__FILE__) + '/../spec_helper'

describe Sprite do
  before(:all) do
    @sprite = Sprite.new
  end
  
  describe "build" do
    it "should build css_sprite image and css" do
      @sprite.build
    end
  end
  
  describe "css_sprite_directories" do
    it "should read two direcoties" do
      expected_directories = [File.join(IMAGE_PATH, 'another_css_sprite'),
                                  File.join(IMAGE_PATH, 'css_sprite')]
      @sprite.css_sprite_directories.should == expected_directories
    end
  end
  
  describe "output_image" do
    it "should output a css_sprite image for a directory" do
      @sprite.output_image(File.join(IMAGE_PATH, 'css_sprite'))
    end
  end
  
  describe "all_images" do
    it "should read all images from a directory" do
      expected_images = [File.join(IMAGE_PATH, 'css_sprite/icons/twitter_icon.png'),
                         File.join(IMAGE_PATH, 'css_sprite/icons/facebook_icon.png'),
                         File.join(IMAGE_PATH, 'css_sprite/hotmail_logo.png'),
                         File.join(IMAGE_PATH, 'css_sprite/gmail_logo.png')]
      @sprite.all_images(File.join(IMAGE_PATH, 'css_sprite')).should == expected_images
    end
  end
  
  describe "dest_image_path" do
    it "should get css_sprite image path for a directory" do
      @sprite.dest_image_path(File.join(IMAGE_PATH, 'css_sprite')).should == File.join(IMAGE_PATH, 'css_sprite.png')
    end
  end

  describe "dest_image_name" do
    it "should get css_sprite image name for a directory" do
      @sprite.dest_image_name(File.join(IMAGE_PATH, 'css_sprite')).should == 'css_sprite.png'
    end
  end

  describe "dest_css_path" do
    it "should get css_sprite css path for a directory" do
      @sprite.dest_css_path(File.join(IMAGE_PATH, 'css_sprite')).should == File.join(STYLESHEET_PATH, 'css_sprite.css')
    end
  end
  
  describe "get_image" do
    it "should get a image" do
      @sprite.get_image(File.join(IMAGE_PATH, 'css_sprite/gmail_logo.png')).class.should == Magick::Image
    end
  end
  
  describe "image_properties" do
    it "should get image properties" do
      image = @sprite.get_image(File.join(IMAGE_PATH, 'css_sprite/gmail_logo.png'))
      @sprite.image_properties(image).should == {:name => 'gmail_logo', :width => 103, :height => 36}
    end
  end
  
  describe "composite_images" do
    it "should composite two images into one horizontally" do
      image1 = @sprite.get_image(File.join(IMAGE_PATH, 'css_sprite/gmail_logo.png'))
      image2 = @sprite.get_image(File.join(IMAGE_PATH, 'css_sprite/hotmail_logo.png'))
      image = @sprite.composite_images(image1, image2, image1.columns, 0)
      @sprite.image_properties(image).should == {:name => "", :width => 206, :height => 36}
    end
    
    it "should composite two images into one verically" do
      image1 = @sprite.get_image(File.join(IMAGE_PATH, 'css_sprite/gmail_logo.png'))
      image2 = @sprite.get_image(File.join(IMAGE_PATH, 'css_sprite/hotmail_logo.png'))
      image = @sprite.composite_images(image1, image2, 0, image1.rows)
      @sprite.image_properties(image).should == {:name => "", :width => 103, :height => 72}
    end
  end
end