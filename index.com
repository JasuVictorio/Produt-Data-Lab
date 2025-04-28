<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics Tool Selector</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #F6FF7A;
            --secondary: #CC99FF;
            --accent: #CC99FF;
            --light: #2E2F30;
            --dark: #191A1B;
            --text: #E1E2E3;
            --text-secondary: #A1A2A3;
            --success: #4cc9f0;
            --warning: #f72585;
            --border-radius: 12px;
            --box-shadow: 0 8px 20px rgba(0,0,0,0.3);
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--dark);
            color: var(--text);
            line-height: 1.6;
            padding: 2rem;
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: var(--light);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
        }
        
        header {
            background: linear-gradient(135deg, var(--dark), #252627);
            color: var(--primary);
            padding: 2rem;
            text-align: center;
            border-bottom: 1px solid #333;
        }
        
        h1 {
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .subtitle {
            font-weight: 300;
            opacity: 0.9;
            color: var(--text-secondary);
            margin-top: 1rem;
        }
        
        .welcome-message {
            background: #252627;
            padding: 1rem;
            margin: 1rem 2rem;
            border-radius: var(--border-radius);
            border-left: 3px solid var(--secondary);
            font-size: 0.95rem;
        }
        
        .decision-tree {
            padding: 2rem;
        }
        
        .node {
            display: none;
            animation: fadeIn 0.3s ease;
        }
        
        .node.active {
            display: block;
        }
        
        .question {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: var(--primary);
        }
        
        .options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .option-btn {
            background: #252627;
            border: 1px solid #333;
            border-radius: var(--border-radius);
            padding: 1.2rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            text-align: center;
            color: var(--text);
        }
        
        .option-btn:hover {
            border-color: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(204, 153, 255, 0.1);
        }
        
        .option-btn:active {
            transform: translateY(0);
        }
        
        .option-btn small {
            color: var(--text-secondary);
            display: block;
            margin-top: 0.3rem;
            font-size: 0.8rem;
        }
        
        .result {
            background: #252627;
            border-radius: var(--border-radius);
            padding: 2rem;
            margin-top: 1rem;
            border-left: 4px solid var(--primary);
        }
        
        .result h3 {
            color: var(--primary);
            margin-bottom: 1rem;
        }
        
        .result p {
            margin-bottom: 0.8rem;
        }
        
        .pros-cons {
            display: flex;
            gap: 1.5rem;
            margin-top: 1.5rem;
        }
        
        .pros, .cons {
            flex: 1;
            padding: 1rem;
            border-radius: var(--border-radius);
            background: rgba(0,0,0,0.2);
        }
        
        .pros {
            border-left: 4px solid var(--primary);
        }
        
        .cons {
            border-left: 4px solid var(--warning);
        }
        
        .pros h4, .cons h4 {
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        
        .pros h4 {
            color: var(--primary);
        }
        
        .cons h4 {
            color: var(--warning);
        }
        
        .back-btn {
            background: #333;
            border: none;
            border-radius: 6px;
            padding: 0.6rem 1.2rem;
            font-weight: 500;
            cursor: pointer;
            margin-top: 1.5rem;
            transition: background 0.2s ease;
            color: var(--text);
        }
        
        .back-btn:hover {
            background: #444;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .tool-icon {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: var(--secondary);
        }
        
        .progress-bar {
            height: 6px;
            background: #333;
            border-radius: 3px;
            margin-bottom: 2rem;
            overflow: hidden;
        }
        
        .progress {
            height: 100%;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            width: 0%;
            transition: width 0.3s ease;
        }
        
        .more-info {
            text-align: center;
            margin: 2rem 0;
        }
        
        .info-btn {
            background: var(--secondary);
            color: var(--dark);
            border: none;
            border-radius: 6px;
            padding: 0.8rem 1.5rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
        }
        
        .info-btn:hover {
            background: var(--primary);
            transform: translateY(-2px);
        }
        
        footer {
            text-align: center;
            margin-top: 2rem;
            padding: 1.5rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
            border-top: 1px solid #333;
        }
        
        footer a {
            color: var(--secondary);
            text-decoration: none;
        }
        
        footer a:hover {
            text-decoration: underline;
        }
        
        ul {
            padding-left: 1.2rem;
            margin-bottom: 1rem;
        }
        
        li {
            margin-bottom: 0.3rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Analytics Tool Selector</h1>
            <p class="subtitle">Find the perfect analytics solution for your product</p>
        </header>
        
        <div class="welcome-message">
            <p>Hey, I know choosing the right analytics tool can be tricky. This quick guide will help you find the best fit based on your product type and needs.</p>
        </div>
        
        <div class="progress-bar">
            <div class="progress" id="progress"></div>
        </div>
        
        <div class="decision-tree">
            <!-- Initial Question -->
            <div class="node active" id="q1">
                <div class="question">What type of product are you working on?</div>
                <div class="options">
                    <div class="option-btn" onclick="showNode('q2-web', 33)">
                        <div class="tool-icon">🌐</div>
                        <div>Website</div>
                        <small>Marketing sites, blogs, etc.</small>
                    </div>
                    <div class="option-btn" onclick="showNode('q2-webapp', 33)">
                        <div class="tool-icon">💻</div>
                        <div>Web App</div>
                        <small>SaaS products, dashboards</small>
                    </div>
                    <div class="option-btn" onclick="showNode('q2-mobile', 33)">
                        <div class="tool-icon">📱</div>
                        <div>Mobile App</div>
                        <small>iOS/Android applications</small>
                    </div>
                </div>
            </div>

            <!-- Website Path -->
            <div class="node" id="q2-web">
                <div class="question">Do you have Google Tag Manager (GTM) set up?</div>
                <div class="options">
                    <div class="option-btn" onclick="showResult('ga4-hotjar', 100)">
                        <div>Yes</div>
                        <small>I can add tags myself</small>
                    </div>
                    <div class="option-btn" onclick="showNode('q3-cms', 66)">
                        <div>No</div>
                        <small>Need alternative setup</small>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q1', 0)">← Back</button>
            </div>

            <!-- Website + No GTM -->
            <div class="node" id="q3-cms">
                <div class="question">Is the website built on a CMS (e.g., WordPress, Shopify)?</div>
                <div class="options">
                    <div class="option-btn" onclick="showResult('ga4-plugin', 100)">
                        <div>Yes</div>
                        <small>WordPress, Shopify, etc.</small>
                    </div>
                    <div class="option-btn" onclick="showResult('ga4-dev', 100)">
                        <div>No</div>
                        <small>Custom coded website</small>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q2-web', 33)">← Back</button>
            </div>

            <!-- Web App Path -->
            <div class="node" id="q2-webapp">
                <div class="question">What's your primary analytics goal?</div>
                <div class="options">
                    <div class="option-btn" onclick="showResult('mixpanel', 100)">
                        <div>User Behavior</div>
                        <small>Feature usage, engagement</small>
                    </div>
                    <div class="option-btn" onclick="showResult('amplitude', 100)">
                        <div>Funnels & Retention</div>
                        <small>Conversion paths, cohorts</small>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q1', 0)">← Back</button>
            </div>

            <!-- Mobile App Path -->
            <div class="node" id="q2-mobile">
                <div class="question">Is Firebase already integrated?</div>
                <div class="options">
                    <div class="option-btn" onclick="showResult('firebase', 100)">
                        <div>Yes</div>
                        <small>Use existing implementation</small>
                    </div>
                    <div class="option-btn" onclick="showResult('app-store', 100)">
                        <div>No</div>
                        <small>Need quick insights</small>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q1', 0)">← Back</button>
            </div>

            <!-- Results -->
            <div class="node result" id="ga4-hotjar">
                <h3>Recommended: Google Analytics 4 + Hotjar</h3>
                <p><strong>Best for:</strong> Websites needing traffic + UX insights</p>
                <p><strong>Setup:</strong> Add GA4 & Hotjar via Google Tag Manager (no devs needed after initial GTM setup)</p>
                
                <div class="pros-cons">
                    <div class="pros">
                        <h4>✓ Pros</h4>
                        <ul>
                            <li>Free to use</li>
                            <li>Comprehensive traffic data</li>
                            <li>Visual session recordings</li>
                            <li>Heatmaps identify UX issues</li>
                        </ul>
                    </div>
                    <div class="cons">
                        <h4>✗ Cons</h4>
                        <ul>
                            <li>Limited custom event tracking</li>
                            <li>Hotjar free plan has limits</li>
                            <li>Requires GDPR compliance</li>
                        </ul>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q2-web', 33)">← Back</button>
            </div>

            <div class="node result" id="ga4-plugin">
                <h3>Recommended: GA4 via CMS Plugin</h3>
                <p><strong>Best for:</strong> CMS-based websites (WordPress, Shopify)</p>
                <p><strong>Setup:</strong> Use MonsterInsights (WordPress) or native Shopify integration</p>
                
                <div class="pros-cons">
                    <div class="pros">
                        <h4>✓ Pros</h4>
                        <ul>
                            <li>Zero coding required</li>
                            <li>Pre-configured dashboards</li>
                            <li>Ecommerce tracking (Shopify)</li>
                        </ul>
                    </div>
                    <div class="cons">
                        <h4>✗ Cons</h4>
                        <ul>
                            <li>Less flexible than GTM</li>
                            <li>Plugin costs for premium features</li>
                        </ul>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q3-cms', 66)">← Back</button>
            </div>

            <div class="node result" id="ga4-dev">
                <h3>Recommended: Basic GA4 Implementation</h3>
                <p><strong>Best for:</strong> Custom-coded websites without GTM</p>
                <p><strong>Setup:</strong> Ask developers to add GA4 script once, then use default reports</p>
                
                <div class="pros-cons">
                    <div class="pros">
                        <h4>✓ Pros</h4>
                        <ul>
                            <li>Minimal dev effort (one-time)</li>
                            <li>All basic traffic metrics</li>
                            <li>Free forever</li>
                        </ul>
                    </div>
                    <div class="cons">
                        <h4>✗ Cons</h4>
                        <ul>
                            <li>Limited customization</li>
                            <li>No advanced tracking</li>
                        </ul>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q3-cms', 66)">← Back</button>
            </div>

            <div class="node result" id="mixpanel">
                <h3>Recommended: Mixpanel</h3>
                <p><strong>Best for:</strong> Web apps needing detailed user behavior analysis</p>
                <p><strong>Setup:</strong> Install via GTM or npm (non-critical path). Use auto-tracked events.</p>
                
                <div class="pros-cons">
                    <div class="pros">
                        <h4>✓ Pros</h4>
                        <ul>
                            <li>Powerful segmentation</li>
                            <li>No-code dashboards</li>
                            <li>Feature adoption tracking</li>
                        </ul>
                    </div>
                    <div class="cons">
                        <h4>✗ Cons</h4>
                        <ul>
                            <li>Expensive at scale</li>
                            <li>Complex setup for custom events</li>
                        </ul>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q2-webapp', 33)">← Back</button>
            </div>

            <div class="node result" id="amplitude">
                <h3>Recommended: Amplitude</h3>
                <p><strong>Best for:</strong> Product teams focused on funnels & retention</p>
                <p><strong>Setup:</strong> Use npm/CDN (non-critical path). Free tier available.</p>
                
                <div class="pros-cons">
                    <div class="pros">
                        <h4>✓ Pros</h4>
                        <ul>
                            <li>Best-in-class funnel analysis</li>
                            <li>Generous free tier</li>
                            <li>Behavioral cohorting</li>
                        </ul>
                    </div>
                    <div class="cons">
                        <h4>✗ Cons</h4>
                        <ul>
                            <li>Steep learning curve</li>
                            <li>Custom events need dev work</li>
                        </ul>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q2-webapp', 33)">← Back</button>
            </div>

            <div class="node result" id="firebase">
                <h3>Recommended: Firebase Analytics</h3>
                <p><strong>Best for:</strong> Mobile apps with Firebase SDK</p>
                <p><strong>Setup:</strong> Use pre-defined events in Firebase Console</p>
                
                <div class="pros-cons">
                    <div class="pros">
                        <h4>✓ Pros</h4>
                        <ul>
                            <li>Free with Google ecosystem</li>
                            <li>Tracks crashes + performance</li>
                            <li>Easy audience creation</li>
                        </ul>
                    </div>
                    <div class="cons">
                        <h4>✗ Cons</h4>
                        <ul>
                            <li>Limited to mobile</li>
                            <li>Basic reporting</li>
                        </ul>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q2-mobile', 33)">← Back</button>
            </div>

            <div class="node result" id="app-store">
                <h3>Use App Store/Play Console Data</h3>
                <p><strong>Best for:</strong> Quick insights without implementation</p>
                <p><strong>Setup:</strong> Access data via Apple/Google developer accounts</p>
                
                <div class="pros-cons">
                    <div class="pros">
                        <h4>✓ Pros</h4>
                        <ul>
                            <li>Zero setup required</li>
                            <li>Direct source of truth</li>
                            <li>Revenue tracking</li>
                        </ul>
                    </div>
                    <div class="cons">
                        <h4>✗ Cons</h4>
                        <ul>
                            <li>No behavioral data</li>
                            <li>Delayed reporting</li>
                        </ul>
                    </div>
                </div>
                <button class="back-btn" onclick="showNode('q2-mobile', 33)">← Back</button>
            </div>
        </div>
        
        <div class="more-info">
            <a href="https://www.notion.so/rootstrap/Product-Data-Lab-1df59347eba68048af14c3cda9507fdf" class="info-btn" target="_blank">
                📊 Find more info in: The Product Data Lab
            </a>
        </div>
    </div>
    
    <footer>
        If you have questions, don't hesitate to contact me: <a href="mailto:jasury.victorio@rootstrap.com">jasury.victorio@rootstrap.com</a>
    </footer>

    <script>
        function showNode(nodeId, progress) {
            document.querySelectorAll('.node').forEach(node => node.classList.remove('active'));
            document.getElementById(nodeId).classList.add('active');
            document.getElementById('progress').style.width = progress + '%';
        }

        function showResult(resultId, progress) {
            document.querySelectorAll('.node').forEach(node => node.classList.remove('active'));
            document.getElementById(resultId).classList.add('active');
            document.getElementById('progress').style.width = progress + '%';
        }
    </script>
</body>
</html>
