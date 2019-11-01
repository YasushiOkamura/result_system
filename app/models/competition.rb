# frozen_string_literal: true

class Competition < ApplicationRecord
  enumerize :kind, in: %i[short long field relay decathlon heptathlon road]
  enumerize :name, in: %i[man_100m man_200m man_400m man_110mH man_400mH
                          woman_100m woman_200m woman_400m woman_100mH woman_400mH other_short
                          man_800m man_1500m man_3000m man_5000m man_10000m man_3000mSC
                          woman_800m woman_1500m woman_3000m woman_5000m woman_10000m woman_3000mSC other_long
                          man_LJ man_HJ man_PJ man_TJ man_SP man_DT man_JT man_HT
                          woman_LJ woman_HJ woman_PJ woman_TJ woman_SP woman_DT woman_JT woman_HT other_field
                          man_4x100mR man_4x400mR woman_4x100mR woman_4x400mR other_relay decathlon heptathlon road
                          man_5000mW man_10000mW woman_5000mW]
end
