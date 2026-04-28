import '../../data/models/town.dart';

class DefaultTowns {
  const DefaultTowns._();

  static const sourceTowns = <TownModel>[
    TownModel(
      townName: 'တောင်ကြီး',
      type: TownType.source,
      cityCode: 'TGI',
      sortOrder: 0,
    ),
    TownModel(
      townName: 'လားရှိုး',
      type: TownType.source,
      cityCode: 'LSO',
      sortOrder: 1,
    ),
    TownModel(
      townName: 'တာချီလိတ်',
      type: TownType.source,
      cityCode: 'TCL',
      sortOrder: 2,
    ),
  ];

  static const destinationTowns = <TownModel>[
    TownModel(townName: 'ကွန်ဟိန်း', type: TownType.destination, sortOrder: 0),
    TownModel(townName: 'ကာလိ', type: TownType.destination, sortOrder: 1),
    TownModel(townName: 'ကျိုင်းတုံ', type: TownType.destination, sortOrder: 2),
    TownModel(townName: 'ကျေးသီး', type: TownType.destination, sortOrder: 3),
    TownModel(townName: 'ခိုလန်', type: TownType.destination, sortOrder: 4),
    TownModel(townName: 'ဆင်မောင်း', type: TownType.destination, sortOrder: 5),
    TownModel(townName: 'ဆီဆိုင်', type: TownType.destination, sortOrder: 6),
    TownModel(townName: 'ဆိုက်ခေါင်', type: TownType.destination, sortOrder: 7),
    TownModel(townName: 'တန့်ယန်း', type: TownType.destination, sortOrder: 8),
    TownModel(townName: 'တုံလော', type: TownType.destination, sortOrder: 9),
    TownModel(townName: 'တောင်ကြီး', type: TownType.destination, sortOrder: 10),
    TownModel(townName: 'တာကော်', type: TownType.destination, sortOrder: 11),
    TownModel(townName: 'တာချီလိတ်', type: TownType.destination, sortOrder: 12),
    TownModel(townName: 'နမ့်ခမ်း', type: TownType.destination, sortOrder: 13),
    TownModel(townName: 'နမ့်စန်', type: TownType.destination, sortOrder: 14),
    TownModel(
      townName: 'နားကောင်းမှူး',
      type: TownType.destination,
      sortOrder: 15,
    ),
    TownModel(townName: 'ပင်လုံ', type: TownType.destination, sortOrder: 16),
    TownModel(
      townName: 'ပြင်ဦးလွင်',
      type: TownType.destination,
      sortOrder: 17,
    ),
    TownModel(townName: 'ပင်းတယ', type: TownType.destination, sortOrder: 18),
    TownModel(townName: 'မူဆယ်', type: TownType.destination, sortOrder: 19),
    TownModel(townName: 'မန္တလေး', type: TownType.destination, sortOrder: 20),
    TownModel(townName: 'မယ်ယန်း', type: TownType.destination, sortOrder: 21),
    TownModel(townName: 'မိုင်းခတ်', type: TownType.destination, sortOrder: 22),
    TownModel(townName: 'မိုင်းကိုင်', type: TownType.destination, sortOrder: 23),
    TownModel(townName: 'မိုင်းဖြတ်', type: TownType.destination, sortOrder: 24),
    TownModel(townName: 'မိုင်းပျဉ်း', type: TownType.destination, sortOrder: 25),
    TownModel(townName: 'မိုင်းပန်', type: TownType.destination, sortOrder: 26),
    TownModel(townName: 'မိုင်းရယ်', type: TownType.destination, sortOrder: 27),
    TownModel(townName: 'မိုင်းရှူး', type: TownType.destination, sortOrder: 28),
    TownModel(townName: 'မိုင်းယန်း', type: TownType.destination, sortOrder: 29),
    TownModel(townName: 'မိုးနဲ', type: TownType.destination, sortOrder: 30),
    TownModel(townName: 'လဲချား', type: TownType.destination, sortOrder: 31),
    TownModel(townName: 'လွိုင်လင်', type: TownType.destination, sortOrder: 32),
    TownModel(townName: 'လင်းခေး', type: TownType.destination, sortOrder: 33),
    TownModel(townName: 'လားရှိုး', type: TownType.destination, sortOrder: 34),
    TownModel(townName: 'ရန်ကုန်', type: TownType.destination, sortOrder: 35),
    TownModel(townName: 'ရပ်စောက်', type: TownType.destination, sortOrder: 36),
    TownModel(townName: 'ရွှေညောင်', type: TownType.destination, sortOrder: 37),
    TownModel(townName: 'သိန်းနီ', type: TownType.destination, sortOrder: 38),
    TownModel(townName: 'သီပေါ', type: TownType.destination, sortOrder: 39),
    TownModel(townName: 'အင်တော', type: TownType.destination, sortOrder: 40),
    TownModel(townName: 'အေးသာယာ', type: TownType.destination, sortOrder: 41),
    TownModel(townName: 'ကျောက်ဂူ', type: TownType.destination, sortOrder: 42),
  ];

  static const all = <TownModel>[...sourceTowns, ...destinationTowns];
}
