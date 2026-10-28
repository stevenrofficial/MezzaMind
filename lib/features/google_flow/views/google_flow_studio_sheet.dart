import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../player/models/soundscape_mode.dart';
import '../../player/viewmodels/player_viewmodel.dart';
import '../services/google_flow_service.dart';

class GoogleFlowStudioSheet extends StatefulWidget {
  const GoogleFlowStudioSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const GoogleFlowStudioSheet(),
    );
  }

  @override
  State<GoogleFlowStudioSheet> createState() => _GoogleFlowStudioSheetState();
}

class _GoogleFlowStudioSheetState extends State<GoogleFlowStudioSheet> {
  SoundscapeMode _selectedMode = SoundscapeMode.deepFocus;
  bool _isImporting = false;
  String? _statusMessage;

  Future<void> _handleFileImport(GoogleFlowService flowService) async {
    setState(() {
      _isImporting = true;
      _statusMessage = null;
    });

    try {
      final track = await flowService.pickAndImportFile(
        mode: _selectedMode,
        targetBrainwave: _selectedMode.badge,
      );

      if (track != null && mounted) {
        setState(() {
          _statusMessage = 'Imported: "${track.title}"';
        });
        // Auto play on import
        final playerVM = context.read<PlayerViewModel>();
        await playerVM.selectSoundscape(track.toSoundscape(), autoPlay: true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _statusMessage = 'Import error: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isImporting = false;
        });
      }
    }
  }

  Future<void> _handleUrlImport(GoogleFlowService flowService) async {
    final titleController = TextEditingController();
    final urlController = TextEditingController();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceElevated,
        title: const Text('Import from Flow Music'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paste any song link from flowmusic.app or a direct audio URL:',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'Flow Music URL or Audio Stream',
                hintText: 'https://www.flowmusic.app/song/...',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Custom Title (Optional)',
                hintText: 'Auto-detected if blank',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4285F4),
            ),
            child: const Text('Import & Layer'),
          ),
        ],
      ),
    );

    if (confirmed == true && urlController.text.trim().isNotEmpty) {
      final track = await flowService.importFromUrl(
        url: urlController.text.trim(),
        title: titleController.text.trim(),
        mode: _selectedMode,
        targetBrainwave: _selectedMode.badge,
      );

      if (mounted) {
        final playerVM = context.read<PlayerViewModel>();
        await playerVM.selectSoundscape(track.toSoundscape(), autoPlay: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final flowService = context.watch<GoogleFlowService>();
    final playerVM = context.watch<PlayerViewModel>();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: Color(0xFF4285F4), width: 1.5)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderSubtle,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4285F4),
                          Color(0xFF34A853),
                          Color(0xFFFBBC05),
                          Color(0xFFEA4335),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GOOGLE FLOW STUDIO',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Import & layer neural frequencies onto Google Flow tracks',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, size: 20),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Brainwave Entrainment Target Selector
          const Text(
            'SELECT TARGET BRAINWAVE ENTRAINMENT LAYER',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: SoundscapeMode.values.map((mode) {
                final isSelected = mode == _selectedMode;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(mode.title),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedMode = mode),
                    selectedColor: const Color(0xFF4285F4).withOpacity(0.2),
                    backgroundColor: AppColors.surfaceElevated,
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF4285F4)
                          : AppColors.borderSubtle,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // Import Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isImporting
                      ? null
                      : () => _handleFileImport(flowService),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4285F4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: _isImporting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.file_upload_outlined, size: 18),
                  label: const Text(
                    'Import Audio File',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: () => _handleUrlImport(flowService),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                ),
                icon: const Icon(Icons.link_rounded, size: 18),
                label: const Text(
                  'Paste URL',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          if (_statusMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              _statusMessage!,
              style: const TextStyle(fontSize: 11, color: AppColors.activeGreen),
            ),
          ],

          const SizedBox(height: 20),

          // Imported Tracks Shelf
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ACTIVE GOOGLE FLOW TRACKS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                  color: AppColors.textTertiary,
                ),
              ),
              Text(
                '${flowService.tracks.length} loaded',
                style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 8),

          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 220),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: flowService.tracks.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final track = flowService.tracks[index];
                final soundscape = track.toSoundscape();
                final isCurrent = playerVM.currentSoundscape.id == track.id;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? const Color(0xFF4285F4).withOpacity(0.12)
                        : AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isCurrent
                          ? const Color(0xFF4285F4).withOpacity(0.6)
                          : AppColors.borderSubtle,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4285F4).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: Color(0xFF4285F4),
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.title,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${track.mode.title} • ${track.targetBrainwave}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: Color(0xFF4285F4),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          playerVM.selectSoundscape(soundscape, autoPlay: true);
                        },
                        icon: Icon(
                          isCurrent && playerVM.isPlaying
                              ? Icons.pause_circle_filled_rounded
                              : Icons.play_circle_filled_rounded,
                          color: const Color(0xFF4285F4),
                          size: 28,
                        ),
                      ),
                      if (flowService.tracks.length > 1)
                        IconButton(
                          onPressed: () => flowService.removeTrack(track.id),
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            size: 18,
                            color: AppColors.textTertiary,
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
