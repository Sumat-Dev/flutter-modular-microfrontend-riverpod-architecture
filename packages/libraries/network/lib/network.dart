/// network
///
/// Shared network infrastructure. Features depend on the [ApiClient]
/// abstraction rather than Dio directly, keeping the transport swappable.
library;

import 'package:network/network.dart' show ApiClient;
import 'package:network/src/api_client.dart' show ApiClient;

export 'src/api_client.dart';
export 'src/dio_api_client.dart';
export 'src/network_exception_mapper.dart';
export 'src/poke_api_service.dart';
