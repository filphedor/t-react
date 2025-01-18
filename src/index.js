import './bundle.scss';

import React from 'react';
import { createRoot } from 'react-dom/client';

import Routing from '/components/routing/routing';

const root = createRoot(document.getElementById('root'));
root.render(<Routing/>);
