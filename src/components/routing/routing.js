import React from "react";

import { createBrowserRouter, RouterProvider } from "react-router-dom";

import Base from '/components/base/base';


let Routing = function() {
    const router = createBrowserRouter([
        {
          path: "/base",
          element: <Base/>,
        }
      ]);


    return (
        <div>
            <span>Routing</span>
            <div>
                <RouterProvider router={router} />
            </div>
        </div>
    );
};

export default Routing;