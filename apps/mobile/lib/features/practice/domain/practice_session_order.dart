/// Practice order after a lesson: the lesson uses the first two boards
/// (Example and Try it), so Practice starts with fresh ones and revisits
/// those last as reinforcement.
List<T> practiceSessionOrder<T>(List<T> scenarios) => scenarios.length > 2
    ? [...scenarios.skip(2), ...scenarios.take(2)]
    : List<T>.of(scenarios);
