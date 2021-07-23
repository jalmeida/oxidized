class NXOS_VDC < Oxidized::Model
  prompt /^(\r?[\w.@_()-]+[#]\s?)$/
  comment '! '

  def filter(cfg)
    cfg.gsub! /\r\n?/, "\n"
    cfg.gsub! prompt, ''
  end

  cmd :secret do |cfg|
    cfg.gsub! /^(snmp-server community).*/, '\\1 <configuration removed>'
    cfg.gsub! /^(snmp-server user (\S+) (\S+) auth (\S+)) (\S+) (priv) (\S+)/, '\\1 <configuration removed> '
    cfg.gsub! /^(username \S+ password \d) (\S+)/, '\\1 <secret hidden>'
    cfg.gsub! /^(radius-server key).*/, '\\1 <secret hidden>'
    cfg
  end

  cmd 'show version' do |cfg|
    cfg = filter cfg
    cfg = cfg.each_line.take_while { |line| not line.match(/uptime/i) }
    comment cfg.join ""
  end

#############################
#
# Addons Begin
#
#############################

# N7K-Admin, N5K
  cmd 'show license' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K (N7K-VDC is the same as N7K-Admin)
  cmd 'show license usage' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K
  cmd 'show license host-id' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin
  cmd 'show system redundancy status' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K (N7K-VDC is the same as N7K-Admin)
  cmd 'show environment fan' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N5K
#  cmd 'show environment fex all fan' do |cfg|
#    cfg = filter cfg
#    comment cfg
#  end

# N7K-Admin, N5K (N7K-VDC is the same as N7K-Admin)
  cmd 'show environment temperature' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K (N7K-VDC is the same as N7K-Admin)
  cmd 'show environment power' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K
  cmd 'show boot' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K (N7K-VDC just list a folder deom N7K-Admin)
  cmd 'dir bootflash:' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K (N7K-VDC is the same as N7K-Admin)
  cmd 'dir debug:' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K (N7K-VDC just list a folder deom N7K-Admin)
  cmd 'dir log:' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin
  cmd 'dir logflash:' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin
  cmd 'dir slot0:' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K (N7K-VDC is the same as N7K-Admin)
  cmd 'dir usb1:' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin (N7K-VDC is the same as N7K-Admin)
  cmd 'dir usb2:' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K (N7K-VDC just list a folder deom N7K-Admin)
  cmd 'dir volatile:' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K (N7K-VDC is the same as N7K-Admin)
  cmd 'show module' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N5K
#  cmd 'show module fex all' do |cfg|
#    cfg = filter cfg
#    comment cfg
#  end

# N5K
#  cmd 'show fex' do |cfg|
#    cfg = filter cfg
#    comment cfg
#  end

# N7K-VDC, N5K
#  cmd 'show interface transceiver' do |cfg|
#    cfg = filter cfg
#    comment cfg
#  end

# N7K-Admin, N7K-VDC, N5K
  cmd 'show interface status' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N7K-VDC, N5K
  cmd 'show vlan' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N7K-VDC, N5K
# cmd 'show debug' do |cfg|
#    cfg = filter cfg
#    comment cfg
#  end

# N7K-Admin,  N5K
  cmd 'show cores vdc-all' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin,  N5K (N7K-VDC is the same as N7K-Admin)
  cmd 'show processes log vdc-all' do |cfg|
    cfg = filter cfg
    comment cfg
  end

#############################
#
# Addons End
#
#############################

# N7K-Admin, N5K (N7K-VDC is the same as N7K-Admin)
  cmd 'show inventory' do |cfg|
    cfg = filter cfg
    comment cfg
  end

# N7K-Admin, N5K
  cmd 'show running-config vdc-all' do |cfg|
    cfg = filter cfg
    cfg.gsub! /^(show run.*)$/, '! \1'
    cfg.gsub! /^!Time:[^\n]*\n/, ''
    cfg.gsub! /^[\w.@_()-]+[#].*$/, ''
    cfg
  end

  cfg :ssh, :telnet do
    post_login 'terminal length 0'
    pre_logout 'exit'
  end

  cfg :telnet do
    username /^login:/
    password /^Password:/
  end
end
