import type {Metadata} from "next";
import "maplibre-gl/dist/maplibre-gl.css";
import "./globals.css";
export const metadata:Metadata={title:"Relief — Restrooms that meet your needs",description:"Find nearby restrooms by access, cleanliness, accessibility, and current reports."};
export default function RootLayout({children}:{children:React.ReactNode}){return <html lang="en"><body>{children}</body></html>}
