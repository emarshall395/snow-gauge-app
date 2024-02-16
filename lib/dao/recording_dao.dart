import 'package:floor/floor.dart';
import 'package:SnowGauge/entities/recording_entity.dart';

@dao
abstract class RecordingDao {
  // Create
  @insert
  Future<void> insertRecording(Recording recording);

  // Read
  @Query('SELECT * FROM Recording')
  Future<List<Recording>> getAllRecordings();

  @Query('SELECT * FROM Recording WHERE id = :id')
  Stream<Recording?> watchRecordingById(int id);
  
  // Update
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateRecording(Recording user);

  // Delete
  @delete
  Future<void> deleteRecording(Recording user);
}
