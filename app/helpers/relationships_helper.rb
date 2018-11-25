module RelationshipsHelper
  def calculation(menbers)
    #重要な配列
    menbers_count = menbers.count
    groups_count = menbers.count/4
    menbers_point = Array.new(menbers_count)
    point_all = 0
    rank_menbers = Array.new(menbers_count)
    menbers_group = Array.new(menbers_count)
    menbers_relation = Array.new(menbers_count).map{Array.new(menbers_count)}
    
    #初期グループ設定
    (0..(menbers_count-1)).each do |index|
      rank_menbers[index] = index
    end
    rank_menbers.shuffle!
    (0..(menbers_count-1)).each do |index|
      group_id = index % groups_count
      menbers_group[rank_menbers[index]] = group_id
    end
    #関係行列作成
    menbers.each_with_index do |menber1, index1|
      menbers.each_with_index do |menber2, index2|
        if menber1.following?(menber2)
          menbers_relation[index1][index2] = 1
        else
          menbers_relation[index1][index2] = 0
        end
      end
    end
    #ポイント計算
    (0..(menbers_count-1)).each do |index1|
      menbers_point[index1] = fx_point(index1,menbers_count,menbers_group,menbers_relation)
      point_all += menbers_point[index1]
    end
    #暫定順位
    rank_menbers = fx_rank(menbers_count,menbers_point,rank_menbers)
    
    #並び替え
    bool_loop = true
    while bool_loop do
      bool_loop = false
      (0..(menbers_count-1)).each do |rank1|
        ((rank1+1)..(menbers_count-1)).each do |rank2|
          puts rank1
          index1 = rank_menbers[rank1]
          index2 = rank_menbers[rank2]
          if menbers_group[index2] != menbers_group[index1]
            menbers_group_temp = Marshal.load(Marshal.dump(menbers_group)) 
            menbers_point_temp = Array.new(menbers_count)
            point_all_temp = 0
            temp = menbers_group_temp[index1]
            menbers_group_temp[index1] = menbers_group_temp[index2]
            menbers_group_temp[index2] = temp
            (0..(menbers_count-1)).each do |index|
              menbers_point_temp[index] = fx_point(index,menbers_count,menbers_group_temp,menbers_relation)
              point_all_temp += menbers_point_temp[index]
            end
            if point_all_temp > point_all
              menbers_group = Marshal.load(Marshal.dump(menbers_group_temp))
              menbers_point = Marshal.load(Marshal.dump(menbers_point_temp))
              point_all = point_all_temp
              rank_menbers = fx_rank(menbers_count,menbers_point,rank_menbers)
              bool_loop = true
            end
          end
          if bool_loop
            break
          end
        end
        if bool_loop
          break
        end
      end
    end
    #最終ポイント計算
    (0..(menbers_count-1)).each do |index1|
      menbers_point[index1] = fx_point_fin(index1,menbers_count,menbers_group,menbers_relation)
    end
    return menbers_group, groups_count, menbers_point
  end
  
  def fx_point(index1,menbers_count,menbers_group,menbers_relation)
    p = 0
    (0..(menbers_count-1)).each do |index2|
      if menbers_group[index1] == menbers_group[index2]
        p += menbers_relation[index1][index2]
      end
    end
    m = menbers_count
    point = (m**3-m**(3-p))/(m-1)
    return point
  end
  
  def fx_point_fin(index1,menbers_count,menbers_group,menbers_relation)
    p = 0
    (0..(menbers_count-1)).each do |index2|
      if menbers_group[index1] == menbers_group[index2]
        p += menbers_relation[index1][index2]
      end
    end
    point = p
    return point
  end
  
  def fx_rank(menbers_count,menbers_point,rank_menbers)
    (0..(menbers_count-2)).each do |rank0|
      (rank0..(menbers_count-2)).reverse_each do |rank1|
        rank2 = rank1+1
        if menbers_point[rank_menbers[rank2]] < menbers_point[rank_menbers[rank1]]
          temp = rank_menbers[rank1]
          rank_menbers[rank1] = rank_menbers[rank2]
          rank_menbers[rank2] = temp
        end
      end
    end
    return rank_menbers
  end
  
end
