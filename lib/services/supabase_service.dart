import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseService {
  static SupabaseService? _instance;
  late final SupabaseClient _client;

  // Private constructor for singleton pattern
  SupabaseService._() {
    _client = Supabase.instance.client;
  }
  // Singleton instance getter
  static SupabaseService get instance {
    _instance ??= SupabaseService._();
    return _instance!;
  }

  // Initialization method to be called from main.dart
  static Future<void> initialize() async {
    try {
      final supabaseUrl = dotenv.env['SUPABASE_URL'];
      final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

      if (supabaseUrl == null || supabaseAnonKey == null) {
        throw Exception(
          'Supabase credentials not found in environment variables',
        );
      }

      // Log credentials for debugging (remove in production)
      if (kDebugMode) {
        debugPrint('Initializing Supabase with:');
        debugPrint('URL: $supabaseUrl');
        debugPrint('ANON_KEY: ${supabaseAnonKey.substring(0, 10)}...');
      }

      await Supabase.initialize(
        url: supabaseUrl,
        publishableKey: supabaseAnonKey,
      );
      debugPrint('✅ Supabase initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing Supabase: $e');

      // For development, we'll just log the error but continue
      // In production, we might want to handle this differently
      if (kDebugMode) {
        debugPrint('Application will continue with limited functionality');
      } else {
        rethrow;
      }
    }
  }

  // Getter for the Supabase client
  SupabaseClient get client => _client; // Generic CRUD operations
  Future<List<Map<String, dynamic>>> fetchAll(String table) async {
    try {
      final response = await _client
          .from(table)
          .select()
          .order('created_at', ascending: false);
      return response;
    } catch (e) {
      debugPrint('❌ Error fetching data from $table: $e');

      // Return empty list for debug mode if connection fails
      if (kDebugMode) {
        debugPrint(
          '🔄 Returning empty list for $table due to connection error',
        );
        return [];
      }
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchWithFilter(
    String table,
    String column,
    dynamic value,
  ) async {
    try {
      final response = await _client
          .from(table)
          .select()
          .eq(column, value)
          .order('created_at', ascending: false);
      return response;
    } catch (e) {
      debugPrint('❌ Error fetching filtered data from $table: $e');

      // Return empty list for debug mode if connection fails
      if (kDebugMode) {
        debugPrint(
          '🔄 Returning empty list for $table due to connection error',
        );
        return [];
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchById(String table, String id) async {
    try {
      final response = await _client.from(table).select().eq('id', id).single();
      return response;
    } catch (e) {
      debugPrint('❌ Error fetching item by ID from $table: $e');
      rethrow;
    }
  }
  Future<Map<String, dynamic>> insert(
    String table,
    Map<String, dynamic> data,
  ) async {
    try {
      debugPrint('🔄 SupabaseService: Inserting into $table with data: $data');
      final response = await _client.from(table).insert(data).select().single();
      debugPrint('✅ SupabaseService: Successfully inserted into $table');
      return response;
    } catch (e) {
      debugPrint('❌ SupabaseService: Error inserting into $table: $e');
      
      // Log more details about the error
      if (e.toString().contains('JWT')) {
        debugPrint('� SupabaseService: Authentication error - user may not be logged in');
      } else if (e.toString().contains('RLS')) {
        debugPrint('🛡️ SupabaseService: Row Level Security error - check user permissions');
      } else if (e.toString().contains('duplicate key')) {
        debugPrint('🔑 SupabaseService: Duplicate key error - item may already exist');
      }
      
      rethrow;
    }
  }

  Future<Map<String, dynamic>> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response =
          await _client.from(table).update(data).eq('id', id).select().single();
      return response;
    } catch (e) {
      debugPrint('❌ Error updating $table: $e');
      rethrow;
    }
  }

  Future<void> delete(String table, String id) async {
    try {
      await _client.from(table).delete().eq('id', id);
    } catch (e) {
      debugPrint('❌ Error deleting from $table: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> customQuery(String query) async {
    try {
      final response = await _client.rpc(query);
      return response;
    } catch (e) {
      debugPrint('❌ Error executing custom query: $e');
      rethrow;
    }
  }
}
