
  class LineBot::ForCircle::RichMenuManager
    # 基本的にrails cで使う
    # ここのimageとobjectを書き換えてrunの引数に行いたい処理を書いて使う。
    #(現状"create"しか動作確認していない(そんな重要じゃないので後回しにしています))
    def run
      image = File.open("app/assets/images/rich_menus/root_rich_menu_for_circle.png")
      object = {
        "size": {
          "width": 2500,
          "height": 1686
        },
        "selected": false,
        "name": "root",
        "chatBarText": "メニュー",
        "areas": [
          {
            bounds: {x: 0, y: 0, width: 1225, height: 1686},
            action: {type: "uri", uri: "https://yuruspo.herokuapp.com/circle"}
          },
          {
            bounds: {x: 1225, y: 0, width: 1225, height: 843},
            action: {type: "message", text: "ヘルプ"}
          },
          {
            bounds: {x: 1225, y: 843, width: 1225, height: 843},
            action: {type: "uri", uri: "https://yuruspo.herokuapp.com/activities/new"}
          }
        ]
      }
      create_or_update_rich_menu object, image #if str == "create"
      set_rich_menu_to_default(get_rich_menu_object_by_name("root")["richMenuId"])
      # update_rich_menu_object object if str == "updateObject"
      # update_rich_menu_image image if str == "updateImage"

    end

    # privateg

    # すでにあるリッチメニューにのみ意味あり。なかったらエラーを吐く
    def update_rich_menu_image name, image_file
      # 古いオブジェクトを取得して削除
      old_rich_menu_object = get_rich_menu_object_by_name name
      delete_rich_menu(old_rich_menu_object["richMenuId"])
      # 古いオブジェクトのコピーを作成してイメージをアップデート
      create_rich_menu(old_rich_menu_object)
      new_rich_menu_object = get_rich_menu_object_by_name name
      create_rich_menu_image(new_rich_menu_object["richMenuId"], image_file)
      #TODO; デフォルトだったらデフォルトに戻す
    end

    # すでにあるリッチメニューにのみ意味あり。なかったらエラーを吐く
    def update_rich_menu_object rich_menu_object
      # 古いオブジェクトと古いイメージを取得して削除
      old_rich_menu_object = get_rich_menu_object_by_name rich_menu_object[:name]
      File.write("tmp/tmp_rich_menu.png", get_rich_menu_image(old_rich_menu_object["richMenuId"]).body)
      old_image = File.open("tmp/tmp_rich_menu.png")
      delete_rich_menu(old_rich_menu_object["richMenuId"])
      # 新しいオブジェクトを作って古いイメージをくっつける
      create_rich_menu(rich_menu_object)
      new_rich_menu_object = get_rich_menu_object_by_name rich_menu_object[:name]
      create_rich_menu_image(new_rich_menu_object["richMenuId"], old_image)
      #TODO: デフォルトだったら元に戻す
    end

    # 作るor両方アップデートしたい時 (うまく動くの実証済み)
    def create_or_update_rich_menu rich_menu_object, image_file
      # 古いオブジェクトを取得して削除
      old_rich_menu_object = get_rich_menu_object_by_name rich_menu_object[:name]
      delete_rich_menu(old_rich_menu_object["richMenuId"]) unless old_rich_menu_object.nil?
      # 新しいオブジェクトを普通に作る
      create_rich_menu(rich_menu_object)
      new_rich_menu_object = get_rich_menu_object_by_name rich_menu_object[:name]
      create_rich_menu_image(new_rich_menu_object["richMenuId"], image_file)
    end


    def delete_all_rich_menu
      rich_menu_objects = get_rich_menu_objects
      rich_menu_objects["richmenus"].each { |object|
        delete_rich_menu(object["richMenuId"])
      }
    end

    def set_rich_menu_to_default rich_menu_id
      c = client
      request = Line::Bot::Request.new do |config|
        config.httpclient     = c.httpclient
        config.endpoint       = c.endpoint
        config.endpoint_path  = "/bot/user/all/richmenu/#{rich_menu_id}"
        config.credentials    = c.credentials
      end
      request.post
    end



    def get_rich_menu_objects
      response = get_rich_menus
      json = JSON.parse(response.body.force_encoding("UTF-8"))
      return json
    end

    def get_rich_menu_object_by_name name
      rich_menu_objects = get_rich_menu_objects
      filtered = rich_menu_objects["richmenus"].select {|object| object["name"] == name}
      object = !filtered.empty? ? filtered[0]:nil
      return object
    end

    def client
      return LineBot::ForCircle::Client.instance
    end

    def get_rich_menus
      client.get_rich_menus
    end

    def get_rich_menu(rich_menu_id)
      client.get_rich_menu
    end

    def create_rich_menu(rich_menu)
      client.create_rich_menu(rich_menu)
    end

    def delete_rich_menu(rich_menu_id)
      client.delete_rich_menu(rich_menu_id)
    end

    def get_user_rich_menu(user_id)
      client.get_user_rich_menu(user_id)
    end

    def link_user_rich_menu(user_id, rich_menu_id)
      client.link_user_rich_menu(user_id, rich_menu_id)
    end

    def unlink_user_rich_menu(user_id)
      client.unlink_user_rich_menu(user_id)
    end

    def get_rich_menu_image(rich_menu_id)
      client.get_rich_menu_image(rich_menu_id)
    end

    def create_rich_menu_image(rich_menu_id, file)
      client.create_rich_menu_image(rich_menu_id, file)
    end
  end
