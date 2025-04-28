import { configureStore } from "@reduxjs/toolkit"
import { setupListeners } from "@reduxjs/toolkit/query"
import { baseApiSlice } from "./api/baseApiSlice"
import { contestApi } from "./api/contestApiSlice" // Import the contestApi slice

export const store = configureStore({
  reducer: {
    [baseApiSlice.reducerPath]: baseApiSlice.reducer,
    [contestApi.reducerPath]: contestApi.reducer, // Add contestApi reducer
  },
  middleware: (getDefaultMiddleware) => getDefaultMiddleware().concat(baseApiSlice.middleware).concat(contestApi.middleware), // Add contestApi middleware
  devTools: process.env.NODE_ENV !== "production",
})

// Enable refetchOnFocus and refetchOnReconnect
setupListeners(store.dispatch)

export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = typeof store.dispatch

export default store
