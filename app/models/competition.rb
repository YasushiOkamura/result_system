class Competition < ApplicationRecord
  enumerize :kind, in: [:short, :long, :field, :relay, :decathlon]
  enumerize :name, in: [:man_100m, :man_200m, :man_400m, :man_110mH, :man_400mH,
                        :woman_100m, :woman_200m, :woman_400m, :woman_110mH, :woman_400mH,
                        :man_800m, :man_1500m, :man_3000m, :man_5000m, :man_10000m, :man_3000mSC,
                        :woman_800m, :woman_1500m, :woman_3000m, :woman_5000m, :woman_10000m, :woman_3000mSC,
                        :man_LJ, :man_HJ, :man_PJ, :man_TJ, :man_SP, :man_DT, :man_JT, :man_HT,
                        :woman_LJ, :woman_HJ, :woman_PJ, :woman_TJ, :woman_SP, :woman_DT, :woman_JT, :woman_HT,
                        :man_100mx4, :man_400mx4, :woman_100mx4, :woman_400mx4, :decathlon]
end
