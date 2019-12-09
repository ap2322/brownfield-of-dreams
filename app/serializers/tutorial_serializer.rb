class TutorialSerializer < ActiveModel::Serializer

  #why not fastjson vs activemodel serializer?


  attributes :id, :title, :description, :thumbnail, :videos

  def videos
    object.videos
  end
end
