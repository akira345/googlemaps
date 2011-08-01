class MapController < ApplicationController
  def index
    palo_alto = [37.4419, -122.1419] # 位置情報を配列で用意  
    # google map api オブジェクトを作成。表示タグ map_div  
    @map = GMap.new("map_div")         
    # 位置の表示  
    @map.center_zoom_init(palo_alto, 10)  
    # 拡大縮小ボタン、地図タイプ切り替えボタン  
    @map.control_init(:large_map => true, :map_type => true)  
    # マーカの指定  
    @map.overlay_init(GMarker.new(palo_alto,  
      :title => "パロアルト",  
      :info_window => "これは情報窓"  
      )  
    )  

  end

end
