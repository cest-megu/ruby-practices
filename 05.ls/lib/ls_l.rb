require 'etc'

def ls_l
  files = []
  num_of_blocks = 0
  @list_of_dir.map do |file|
    # カレントディレクトリ内のファイルをそれぞれfiles配列に格納
    files << file
    num_of_blocks += File.stat(file).blocks
  end
  # ファイルのブロック数
  puts "total #{num_of_blocks}"

  files.map do |file|
    stat = File.stat(file)
    # パーミッション ８進数で表す
    permission = stat.mode.to_s(8)
    # ８進数の桁数を６桁にあわせる
    permission = format('%06d', permission)
    # ８進数を5つに分解
    m = /(\d{2})(\d{1})(\d{1})(\d{1})(\d{1})/.match(permission)
    file_type = m[1] # 1文字目のファイルの種類（タイプ）
    some_permission = m[3..5] # owner,group, otherのパーミッション

    case m[1]
    when '04'
      file_type = 'd'
    when '10'
      file_type = '-'
    when '12'
      file_type = 'l'
    end

    permission_array = []

    some_permission.map do |p|
      case p
      when '0'
        p = '---'
      when '1'
        p = '--x'
      when '2'
        p = '-w-'
      when '3'
        p = '-wx'
      when '4'
        p = 'r--'
      when '5'
        p = 'r-x'
      when '6'
        p = 'rw-'
      when '7'
        p = 'rwx'
      end
      permission_array << p
    end

    # パーミッションを記号で表す
    permission = file_type + permission_array.join('')
    # リンク数
    num_of_links = stat.nlink.to_s
    # オーナー名
    owner_name = Etc.getpwuid(Process.uid).name
    # グループ名
    group = Etc.getgrgid(Process.gid).name
    # ファイルサイズ
    byte_size = stat.size.to_s.rjust(4)
    # タイムスタンプ
    timestamp = stat.mtime

    puts [permission, num_of_links, owner_name, group, byte_size, timestamp, file].join('  ')
  end
end
