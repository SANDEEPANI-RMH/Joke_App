import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './joke.dart';
import './joke_service.dart';
import './app_theme.dart';

class JokeListPage extends StatefulWidget {
  final SharedPreferences prefs;

  const JokeListPage({Key? key, required this.prefs}) : super(key: key);

  @override
  _JokeListPageState createState() => _JokeListPageState();
}

class _JokeListPageState extends State<JokeListPage>
    with SingleTickerProviderStateMixin {
  late final JokeService _jokeService;
  late final AnimationController _animationController;
  List<Joke> _jokes = [];
  bool _isLoading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _jokeService = JokeService(widget.prefs);
    _animationController = AnimationController(
      vsync: this,
      duration: AppTheme.animations['normal']!,
    );
    _loadJokes();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadJokes({bool forceRefresh = false}) async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    try {
      final jokes = await _jokeService.fetchJokes(forceRefresh: forceRefresh);
      setState(() {
        _jokes = jokes;
        _isLoading = false;
      });
      _animationController.reset();
      _animationController.forward();
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildJokeCard(Joke joke, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.5, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          index * 0.1,
          1.0,
          curve: Curves.easeOutCubic,
        ),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            1.0,
            curve: Curves.easeOut,
          ),
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.borderRadius['lg']!,
          ),
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppTheme.cardGradient,
              borderRadius: AppTheme.borderRadius['lg'],
              boxShadow: AppTheme.cardShadow,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withOpacity(0.1),
                          borderRadius: AppTheme.borderRadius['full'],
                        ),
                        child: Text(
                          joke.category,
                          style: const TextStyle(
                            color: Color(0xFF6366F1),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.sentiment_very_satisfied_rounded,
                        color: const Color(0xFF6366F1).withOpacity(0.7),
                        size: 24,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (joke.isTwoPart) ...[
                    Text(
                      joke.setup,
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      joke.delivery,
                      style: TextStyle(
                        color: const Color(0xFF6366F1),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ] else
                    Text(
                      joke.joke,
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [AppTheme.headerShadow],
      ),
      child: Column(
        children: [
          const Text(
            'Daily Jokes',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your daily dose of humor',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isLoading ? null : () => _loadJokes(forceRefresh: true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF6366F1),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                elevation: 4,
                shadowColor: const Color(0xFF6366F1).withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.borderRadius['lg']!,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isLoading)
                    const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                      ),
                    )
                  else ...[
                    const Icon(Icons.refresh_rounded, size: 24),
                    const SizedBox(width: 12),
                    const Text(
                      'Refresh Jokes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.sentiment_very_satisfied_rounded,
              size: 64,
              color: const Color(0xFF6366F1).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No jokes available',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Tap the refresh button to load some jokes!',
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () => _loadJokes(forceRefresh: true),
                color: const Color(0xFF6366F1),
                child: _jokes.isEmpty && !_isLoading
                    ? CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: _buildEmptyState(),
                    ),
                  ],
                )
                    : ListView.builder(
                  padding: const EdgeInsets.only(top: 16, bottom: 24),
                  itemCount: _jokes.length,
                  itemBuilder: (context, index) =>
                      _buildJokeCard(_jokes[index], index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}