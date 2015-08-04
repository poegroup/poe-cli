require.context('./modules/layouts', true, /\.ess$/);
require.context('./modules/pages', true, /\.js$/);
require.context('./modules/pages', true, /\.ess$/);

import 'ui-kit/skins/base/index.ess'
import 'ui-kit/skins/base/normalize.ess'
import './index.ess'
