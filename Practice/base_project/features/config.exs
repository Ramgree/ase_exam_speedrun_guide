defmodule WhiteBreadConfig do
  use WhiteBreadConfig.SuiteConfiguration

  suite name: "All",
    context: WhiteBreadContext,
    feature_paths: ["features/"]

end
