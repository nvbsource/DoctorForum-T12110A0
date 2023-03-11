namespace Doctors_Forum_Server.Repositories
{
    public class ConnectionManagement
    {
        private readonly Dictionary<string, HashSet<string>> _connections =
    new Dictionary<string, HashSet<string>>();

        public int Count => _connections.Count;
        public List<string> GetAllKeys()
        {
            var keys = _connections.Keys.ToList();
            return keys;
        }
        public void Add(string key, string connectionId)
        {
            lock (_connections)
            {
                if (!_connections.TryGetValue(key, out var connections))
                {
                    connections = new HashSet<string>();
                    _connections.Add(key, connections);
                }

                lock (connections)
                {
                    connections.Add(connectionId);
                }
            }
        }

        public IEnumerable<string> GetConnections(string key)
        {
            if (_connections.TryGetValue(key, out var connections))
            {
                return connections;
            }

            return Enumerable.Empty<string>();
        }

        public void Remove(string key, string connectionId)
        {
            lock (_connections)
            {
                if (!_connections.TryGetValue(key, out var connections))
                {
                    return;
                }

                lock (connections)
                {
                    connections.Remove(connectionId);

                    if (connections.Count == 0)
                    {
                        _connections.Remove(key);
                    }
                }
            }
        }
    }
}
