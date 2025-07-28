// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registro_medico_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$registrarDoctorHash() => r'902e7f6cb2b90b504a90cf5af81dd1ea80e55a68';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [registrarDoctor].
@ProviderFor(registrarDoctor)
const registrarDoctorProvider = RegistrarDoctorFamily();

/// See also [registrarDoctor].
class RegistrarDoctorFamily extends Family<AsyncValue<void>> {
  /// See also [registrarDoctor].
  const RegistrarDoctorFamily();

  /// See also [registrarDoctor].
  RegistrarDoctorProvider call(dynamic input) {
    return RegistrarDoctorProvider(input);
  }

  @override
  RegistrarDoctorProvider getProviderOverride(
    covariant RegistrarDoctorProvider provider,
  ) {
    return call(provider.input);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'registrarDoctorProvider';
}

/// See also [registrarDoctor].
class RegistrarDoctorProvider extends AutoDisposeFutureProvider<void> {
  /// See also [registrarDoctor].
  RegistrarDoctorProvider(dynamic input)
    : this._internal(
        (ref) => registrarDoctor(ref as RegistrarDoctorRef, input),
        from: registrarDoctorProvider,
        name: r'registrarDoctorProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$registrarDoctorHash,
        dependencies: RegistrarDoctorFamily._dependencies,
        allTransitiveDependencies:
            RegistrarDoctorFamily._allTransitiveDependencies,
        input: input,
      );

  RegistrarDoctorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.input,
  }) : super.internal();

  final dynamic input;

  @override
  Override overrideWith(
    FutureOr<void> Function(RegistrarDoctorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegistrarDoctorProvider._internal(
        (ref) => create(ref as RegistrarDoctorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        input: input,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _RegistrarDoctorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegistrarDoctorProvider && other.input == input;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, input.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegistrarDoctorRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `input` of this provider.
  dynamic get input;
}

class _RegistrarDoctorProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with RegistrarDoctorRef {
  _RegistrarDoctorProviderElement(super.provider);

  @override
  dynamic get input => (origin as RegistrarDoctorProvider).input;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
