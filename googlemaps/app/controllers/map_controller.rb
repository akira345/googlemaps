# -*- coding: utf-8 -*-
class MapController < ApplicationController
  POINTS = [
    {:point => [35.678355, 139.715109], :name => "国立競技場"}, 
    {:point => [35.67452 , 139.717083], :name => "神宮球場" }, 
    {:point => [35.676472, 139.699316], :name => "明治神宮" }
  ] 
  def index
    # google map api オブジェクトを作成。表示タグ map_div 
    @map = GMap.new("map_div","draggableCursor: 'crosshair'")
   @map.record_init(<<-END)
     // var lat = google.loader.ClientLocation.latitude;
     // var lng = google.loader.ClientLocation.longitude;
		var lat
		var lng
      // 日本橋の座標を設定
      map.setCenter(new GLatLng(35.6840432111695,139.774460792542),14);

      if (lat && lng) {
        // IPアドレスから位置情報を取得できたらその位置を設定する
        map.setCenter(new GLatLng(lat,lng),14);
      } else {
        // 位置情報を取得できなかったら住所検索の結果を設定する
        new GClientGeocoder().getLatLng('新宿区', function(latlng){ if(latlng){map.setCenter(latlng,14);} });
      }

    END


    # 拡大縮小ボタン、地図タイプ切り替えボタン
    @map.control_init(:large_map => true, :map_type => true)
    # マーカーA,B,Cと吹き出しウィンドウを表示する
    POINTS.each do |item|
      @letter = (@letter.succ rescue 'A')
      icon = GIcon.new(:image => "http://www.google.com/mapfiles/marker#{@letter}.png", :copy_base => GIcon::DEFAULT)
      marker = GMarker.new(item[:point], :title => "Hello #{@letter}", :info_window => item[:name], :icon => icon)
      @map.overlay_init(marker)
    end
   @map.record_init(<<-END)
//クリックイベント
    GEvent.addListener(map, 'click', function(overlay, point) {
      if (point) {
        document.getElementById("show_x").innerHTML = point.x;
        document.getElementById("show_y").innerHTML = point.y;
		//form1のhidden各要素に値をセット
		//document.form1.x.value=point.x;
		//document.form1.y.value=point.y;
      }
    }); 
 

	END
  end

end
