require 'json'
require 'fileutils'

class GeoJsonToCity

  def initialize
    @data      = {}
    @data_info = {}
  end

  def split(path)
    Dir.glob(path).each do |path|
      str      = File.open(path).read(nil, '')
      json     = JSON.parse(str)
      features = json['features']
      features.each do |feature|
        # 名称抽出
        addr = self.parse_properties(feature['properties'])
        # properties削除
        feature.delete('properties')
        # 都道府県
        self.set_data(feature, 'prefectures', addr[:pref_code])
        # 行政区分
        unless addr[:code].nil?
          self.set_data(feature, addr[:pref_code], addr[:code])
        end
        # 東京都23区
        if self.is_tokyo23(addr)
          self.set_data(feature, addr[:pref_code], 'tokyo23', addr[:code])
        end
        # 北陸3県
        if self.is_hokuriku(addr)
          self.set_data(feature, 'prefectures', 'hokuriku', addr[:code])
        end
      end
    end
  end

  def is_tokyo23(addr)
    addr[:pref_code].to_i == 13 && addr[:code].to_i >= 13101 && addr[:code].to_i <= 13123
  end

  def is_hokuriku(addr)
    addr[:pref_code].to_i == 16 || addr[:pref_code].to_i == 17 || addr[:pref_code].to_i == 18
  end

  def set_data(feature, dir_name, key, id = nil)
    unless key.nil?
      # data
      unless @data.has_key?(key)
        @data[key] = []
      end
      if id.nil?
        feature['id'] = key
      else
        feature['id'] = id
      end
      @data[key].push(feature)
      # data_info
      unless @data_info.has_key?(key)
        @data_info[key] = {:dir_name => dir_name, :file_name => key}
      end
    end
  end

  def parse_properties(prop)
    pref     = prop['N03_001']
    city1    = prop['N03_002']
    city2    = prop['N03_003']
    city3    = prop['N03_004']
    code     = prop['N03_007']

    city = ''
    unless city1.nil? && pref != '北海道'
      city += city1
    end
    unless city2.nil?
      city += city2
    end
    unless city3.nil?
      city += city3
    end
    if code.nil?
      # 未所属の場合、県名から都道府県コード取得
      pref_code = self.get_pref_code(pref)
    else
      # 行政区分コード先頭2文字が都道府県コード
      pref_code = code[0, 2]
    end
    {:pref => pref, :city => city, :pref_code => pref_code, :code => code}
  end

  def get_pref_code(pref_name)
    pref = %w[
        北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県 茨城県 栃木県 群馬県 埼玉県
        千葉県 東京都 神奈川県 新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県 静岡県
        愛知県 三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県 鳥取県 島根県 岡山県
        広島県 山口県 徳島県 香川県 愛媛県 高知県 福岡県 佐賀県 長崎県 熊本県 大分県
        宮崎県 鹿児島県 沖縄県
    ]

    idx = pref.index(pref_name)
    sprintf('%02d', idx + 1)
  end

  def make
    @data.each do |key, collection|
      data          = {'type' => 'FeatureCollection', 'features' => collection}
      dir_name      = @data_info[key][:dir_name]
      file_name     = @data_info[key][:file_name]
      save_dir_name = "geojson/#{dir_name}"
      p "geo #{file_name}"
      FileUtils.mkdir_p(save_dir_name)
      File.open("#{save_dir_name}/#{file_name}.json", 'w').write(JSON.generate(data))
    end
  end

end

city = GeoJsonToCity.new
japan_json = './data/geojson/japan2016.json'
city.split(japan_json)

city.make()
