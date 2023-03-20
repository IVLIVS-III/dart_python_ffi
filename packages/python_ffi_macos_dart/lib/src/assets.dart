import "package:gunnison/gunnison.dart";
import "package:gunnison_assets/gunnison_assets.dart";

// Here, we load the to-be-generated assets file, which contains the actual asset content.
part "assets.g.dart";

// You can also have JSON assets (JsonAsset is a subclass of TextAsset).
@Asset("asset:my_package/web/my-asset.json")
const JsonAsset moduleJsonAsset = JsonAsset(text: _moduleJsonAsset$content);
