namespace :video_position do
  desc 'update positions from nil to zero'
  task :videos, [:videos] => :environment do
    videos = Video.all
    videos.each do |video|
      if video.position.nil? && video.tutorial
        video.update_attribute(:position, video.tutorial.video_count + 1)
      elsif video.position.nil?
        video.update_attribute(:position, 0)
      end
    end
  end
end
